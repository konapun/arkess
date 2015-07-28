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
        print "Got cancelable $cancelable\n";
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

      my $event; # Need to keep track of this so it can be unregistered
      $cb ||= sub{}; # NOP
      $event = $cob->on(Arkess::Event::BEFORE_RENDER, sub { # Return event which can be unregistered
        my ($cobX, $cobY) = $cob->getCoordinates();

        if ($cobX < $x) {
          $cob->move(Arkess::Direction::RIGHT);
        }
        elsif ($cobX > $x) {
          $cob->move(Arkess::Direction::LEFT);
        }
        if ($cobY < $y) {
          $cob->move(Arkess::Direction::DOWN);
        }
        elsif ($cobY > $y) {
          $cob->move(Arkess::Direction::UP);
        }

        ($cobX, $cobY) = $cob->getCoordinates(); # Recheck coords after ops
        if ($cobX == $x && $cobY == $y) {
          $event->unregister();
          $cb->();
        }
      });
      return $event;
    },

    follow => sub {
      my ($cob, $toFollow, $lagDistance, $warpDistance) = @_;

      $lagDistance = ($toFollow->getWidth() + 5) unless defined $lagDistance; # How far to follow behind $toFollow
      $warpDistance = $lagDistance * 2 unless defined $warpDistance; # How far behind $toFollow $cob can be before it's warped to $toFollow (in case it gets stuck on something)
      return $toFollow->on('move', sub { # Return event which can be unregistered
        my ($direction, $units) = @_;

        return unless $direction;
        my $lagDistanceX = $lagDistance;
        my $lagDistanceY = $lagDistance;
        $lagDistanceX = 0 if $direction eq Arkess::Direction::UP || $direction eq Arkess::Direction::DOWN;
        $lagDistanceY = 0 if $direction eq Arkess::Direction::LEFT || $direction eq Arkess::Direction::RIGHT;
        my ($x, $y) = $toFollow->getCoordinates();
        my ($x2, $y2) = $cob->getCoordinates();
        my ($distanceX, $distanceY) = $cob->getDistanceFrom($toFollow, 1);
        if (($distanceX > $warpDistance) || ($distanceY > $warpDistance)) { # warp to $toFollow
          $cob->setCoordinates($x, $y);
        }
        else { # follow normally
          if ($x2+$lagDistanceX < $x) {
            $cob->move(Arkess::Direction::RIGHT);
          }
          elsif ($x2-$lagDistanceX > $x) {
            $cob->move(Arkess::Direction::LEFT);
          }
          if ($y2+$lagDistanceY < $y) {
            $cob->move(Arkess::Direction::DOWN);
          }
          elsif ($y2-$lagDistanceY > $y) {
            $cob->move(Arkess::Direction::UP);
          }
        }
      });
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Automated - A component for entites which support automated
operations, such as AI
