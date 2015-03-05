package Arkess::Component::Automated;

use strict;
use Arkess::Event;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::D4', # FIXME: D4 isn't the only component that should accept automation. Maybe granulate into Arkess::Component::Controllable?
    'Arkess::Component::RuntimeAware',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my $self = shift;

  $self->{automations} = {}; # in the form of name => { playing => 0, code => CODEREF }
};

sub exportAttributes {
  return {
    automated => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {

    addAutomation => sub {
      my ($cob, $name, $sub) = @_;

      $self->{automations}->{$name} = {
        playing => 0,
        code    => $sub
      };
    },

    removeAutomation => sub {
      my ($cob, $name) = @_;

      if ($cob->isAutomationPlaying($name)) { # defer the remove operation
        # TODO
      }
      if ($self->{automations}->{$name}) {
        return delete $self->{automations}->{$name};
      }
      return sub{};
    },

    playAutomation => sub {
      my ($cob, $name) = @_;

      my $cancelable;
      if (!$cob->isAutomationPlaying($name)) {
        $self->{automations}->{$name}->{cancelable} = $cancelable;
        $cancelable = $self->{automations}->{$name}->{code}->($cob);
      }
      else { # get stoppable handle
        # TODO
      }

      return $cancelable;
    },

    isAutomationPlaying => sub {
      my ($cob, $name) = @_;

      if (!$self->{automations}->{$name}) {
        return $self->{automations}->{$name}->{playing};
      }
      return 0;
    },

    stopAutomation => sub {
      my ($cob, $name) = @_;

      if ($cob->isAutomationPlaying($name)) {
        # TODO
        print "TODO\n";
      }
    },

    loopAutomation => sub {
      my ($cob, $name) = @_;

      $cob->playAutomation($name, sub {
        $cob->loopAutomation($name);
      });
    },

    moveTo => sub {
      my ($cob, $x, $y, $cb) = @_;

      my $event;
      $cb ||= sub{}; # NOP
      $event = $cob->on(Arkess::Event::BEFORE_RENDER, sub {
        my ($cobX, $cobY) = $cob->getCoordinates();

#        print "Moving cob at ($cobX, $cobY) to ($x, $y)\n";
        if ($cobX < $x) {
          $cob->move(Arkess::Direction::RIGHT);
        }
        elsif ($cobX > $x) {
          $cob->move(Arkess::Direction::LEFT);
        }
        if ($cobY < $y) {
          print "$self; xMOVING DOWN (from $cobY to $y)\n";
          $cob->move(Arkess::Direction::DOWN);
        }
        elsif ($cobY > $y) {
          print "$self: MOVING UP (from $cobY to $y)\n";
          $cob->move(Arkess::Direction::UP);
        }

        if ($cobX == $x && $cobY == $y) {
          print "UNREGISTERING EVENT\n";
          $event->unregister();
          $cb->();
        }
      });
      return $event;
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Automated - A component for entites which support automated
operations, such as AI
