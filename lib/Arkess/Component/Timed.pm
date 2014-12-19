package Arkess::Component::Timed;

use strict;
use Time::HiRes qw(gettimeofday tv_interval);
use Arkess::Event;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $interval) = @_;

  $self->{interval} = $interval;
}

sub requires {
  return [
    'Arkess::Component::RuntimeAware' # Main gameloop registers with events triggered by the runtime to update time
  ];
}

sub exportMethods {
  my $self = shift;

  return {

    # Register an event to be run on a given interval. Returns a handle to the
    # created event to allow cancellation
    registerTimedEvent => sub {
      my ($cob, $callback, $interval, $iterations) = @_;

      $interval = $self->{interval} unless defined $interval;
      die "Timed event requires interval" unless defined $interval;

      if ($iterations) {
        return $cob->registerTimedEventOnce($callback, $interval, $iterations);
      }

      my $lastTick = [gettimeofday];
      my $elapsed = $interval; # So timed event executes before waiting for a timeout the first time
      my $timedEvent = $cob->getEventBus()->bind(Arkess::Event::LOOP_START, sub {
        if ($elapsed >= $interval) {
          $callback->();
          $lastTick = [gettimeofday];
        }
        $elapsed = tv_interval($lastTick) * 1000;
      });

      return $timedEvent; # call $timedEvent->stop() to unregister this event with the event bus
    },

    # Like registerTimedEvent but will automatically unregister itself after a
    # given number of executions (default: 1)
    registerTimedEventOnce => sub {
      my ($cob, $callback, $interval, $iterations) = @_;

      $iterations = 1 unless defined $iterations;
      my $timedEvent;
      $timedEvent = $cob->registerTimedEvent(sub {
        $callback->();
        $timedEvent->unregister();
      }, $interval);

    }
  };
}

1;
__END__
=head1 NAME
Arkess::Component::Timed - A component for registering actions that are to be
executed on a timer
