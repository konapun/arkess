package Arkess::Component::Observable2;

use strict;
use Arkess::Event;
use Arkess::Event::Bus;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::AttributeChecker',
  ];
}

sub setPriority { # Set a high number so this component can wrap everything else
  return 999;
}

# (Optionally) Make runtime event bus's events observable from the Cobsy object
sub initialize {
  my ($self, $eventBus) = @_;

  $self->{events} = {
    before => Arkess::Event::Bus->new(),
    after  => Arkess::Event::Bus->new()
  };
  $self->{wrapped} = Cobsy::Core::Hash->new(); # don't rewrap methods that are already wrapped or they'll be called multiple times per trigger
  $self->{eventBus} = $eventBus;
}

sub beforeInstall {
  my ($self, $owner) = @_;

  if ($owner->hasAttribute('observable')) { # Don't want to overwrite previously registered events
    $self->{events} = $owner->_getEvents();
    $self->{wrapped} = $owner->_getWrapped();
  }
}

sub afterInstall {
  my ($self, $owner) = @_;

  # Decorate all the owner's methods with a version which executes callbacks after the original method is called.
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    return if $key eq 'trigger' || $key eq 'triggerBefore' || $key eq 'before' || $key eq 'on' || $self->{wrapped}->has($key); # Ignore decorating keys that would cause infinite callbacks
    $owner->methods->set($key, sub {
      my ($cob, @args) = @_;
      my $wantarray = wantarray;

      my @return;
      $owner->triggerBefore($key, @args);
      if (!$wantarray) { # Make sure to return the wrapped sub's value in the same context it's being asked for
        $return[0] = $val->call(@args);
      }
      else {
        @return = $val->call(@args);
      }
      $owner->trigger($key, $wantarray ? @return : $return[0]);
      return $wantarray ? @return : $return[0];
    });
    $self->{wrapped}->set($key, 1);
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

    # Unregister an event from being observed
    dontObserve => sub {
      my ($cob, $event) = @_;


    },

    # Reregister observation for an event
    observe => sub {
      my ($cob, $event) = @_;


    },

    # Register a callback for an event
    on => sub {
      my ($cob, $event, $callback) = @_;

      return $self->{events}->{after}->bind($event, $callback);
    },

    before => sub {
      my ($cob, $event, $callback) = @_;

      return $self->{events}->{before}->bind($event, $callback);
    },

    # Trigger an event with given args
    trigger => sub {
      my ($cob, $event, @args) = @_;

      $self->{events}->{after}->trigger($event, @args);
    },

    triggerBefore => sub {
      my ($cob, $event, @args) = @_;

      $self->{events}->{before}->trigger($event, @args);
    },

    # Allow this component to add new events when installing rathe rthan overwriting
    _getEvents => sub {
      return $self->{events};
    },

    _getWrapped => sub {
      return $self->{wrapped};
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
