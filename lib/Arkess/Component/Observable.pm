package Arkess::Component::Observable;

use strict;
use Arkess::Event;
use Arkess::Event::Bus;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::AttributeChecker'
  ];
}

# (Optionally) Make runtime event bus's events observable from the Cobsy object
sub initialize {
  my ($self, $eventBus) = @_;

  $self->{events} = Arkess::Event::Bus->new();
  $self->{eventBus} = $eventBus;
}

sub beforeInstall {
  my ($self, $owner) = @_;

  if ($owner->hasAttribute('observable')) { # Don't want to overwrite previously registered events
    $self->{events} = $owner->_getEvents();
  }
}

sub afterInstall {
  my ($self, $owner) = @_;

  # Decorate all the owner's methods with a version which executes callbacks after the original method is called.
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    return if $key eq 'trigger' || $key eq 'on'; # Ignore decorating keys that would cause infinite callbacks
    $owner->methods->set($key, sub {
      my ($cob, @args) = @_;

      my $return = $val->call(@args);
      $owner->trigger($key, $return);
      return $return;
    });
  });

  $owner->on('setRuntime', sub {
    $self->_registerRuntimeEvents($owner, shift->getEventBus());
  });
}

sub exportAttributes {
  return {
    observable => 1
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

      return $self->{events}->bind($event, $callback);
    },

    # Trigger an event with given args
    trigger => sub {
      my ($cob, $event, @args) = @_;

      $self->{events}->trigger($event, @args);
    },

    # Allow this component to add new events when installing rathe rthan overwriting
    _getEvents => sub {
      return $self->{events};
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
