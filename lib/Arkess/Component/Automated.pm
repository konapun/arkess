package Arkess::Component::Automated;

use strict;
use Arkess::Event;
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

  $self->{automations} = {}; # in the form of name => sub
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

      $self->{automations}->{$name} = $sub;
    },

    playAutomation => sub {
      my ($cob, $name) = @_;

      my $cb = $self->{automations}->{$name};
      $cb->($cob);
      return $cb; # FIXME: return something that can be unregistered or a deferred
    },

    stopAutomation => sub {
      my ($cob, $name) = @_;

      die "TODO\n";
    },

    loopAutomation => sub {
      my ($cob, $name) = @_;

      my $cb = $cob->playAutomation($name);
      $cob->on('automationDone', sub {
        my ($name, $coderef) = @_;

        #print "NAME: $name, coderef: $coderef\n";
        #$cob->playAnimation($name);
      });
    },

    moveTo => sub {
      my ($cob, $x, $y, $cb) = @_;

      my $event;
      $cb ||= sub{}; # NOP
      $event = $cob->on(Arkess::Event::BEFORE_RENDER, sub {
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

        if ($cobX == $x && $cobY == $y) {
          $event->unregister();
          $cob->trigger('automationDone', 'moveTo');
          $cb->();
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
