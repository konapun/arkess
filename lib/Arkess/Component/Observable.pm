package Arkess::Component::Observable;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::AttributeChecker'
  ];
}

# (Optionally) Make runtime event bus's events observable from the Cobsy object
sub initialize {
  my ($self, $eventBus) = @_;

  $self->{eventBus} = $eventBus;
}

sub afterInstall {
  my ($self, $owner) = @_;

  my $eventBus = $self->{eventBus};
  if (!$eventBus) { # See if event bus can be found through another component
    if ($owner->hasAttribute('runtimeAware')) {
      $eventBus = $owner->getEventBus();
    }
  }

  $self->_registerRuntimeEvents($owner, $eventBus) if $eventBus;

  # Need to make sure this doesn't alter the "base" object...
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    return if $key eq 'trigger' || $key eq 'on';
    $owner->methods->set($key, sub {
      my ($cob, @args) = @_;

      my $return = $val->call(@args);
      $owner->trigger($key, $return);
      return $return;
    });
  });
}

sub exportAttributes {
  return {
    events => {}
  };
}

sub exportMethods {
  my $self = shift;

  return {

    # Observable property changes for Cobs
    set => sub {
      my ($cob, $key, $value, $observable) = @_;

      $observable = 1 unless defined $observable; # automatically trigger change event on set
      my $oldValue = $cob->attributes->has($key) ? $cob->attributes->get($key) : undef;
      my $ret = $cob->attributes->set($key, $value);
      $cob->trigger('change', $key, $value, $oldValue);
      return $ret;
    },

    # Register this cob with all events triggered by the runtime
    setEventBus => sub {
      my ($cob, $bus) = @_;

      $self->_registerRuntimeEvents($cob, $bus);
    },

    # Register a callback for an event
    on => sub {
      my ($cob, $event, $callback) = @_;

      $self->{events}->{$event} = [] unless defined $self->{events}->{$event};
      push(@{$self->{events}->{$event}}, $callback);
      return $callback; # so it can be used to unregister (more on this later)
    },

    # Trigger an event with given args
    trigger => sub {
      my ($cob, $event, @args) = @_;

      return unless defined $self->{events}->{$event};
      foreach my $cb (@{$self->{events}->{$event}}) {
        $cb->(@args);
      }
    }

  };
}

sub _registerRuntimeEvents {
  my ($self, $cob, $eventBus) = @_;

  foreach my $event (Arkess::Event::getAll()) {
    $eventBus->bind($event, sub {
      $cob->trigger($event, @_);
    });
  }
}

1;
