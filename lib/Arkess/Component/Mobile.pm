package Arkess::Component::Mobile;

use strict;
use Arkess::Direction::2D;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned'
  ];
}

sub initialize {
  my ($self, $units) = @_;

  $self->{units} = defined $units ? $units : 1; # How many units to move on strafe or move
  $self->{mobile} = 1; # player can move
}

sub setPriority {
  return 300;
}

sub exportMethods {
  my $self = shift;

  return {

    setSpeed => sub {
      my ($cob, $units) = @_;

      $self->{units} = $units;
    },

    getSpeed => sub {
      return $self->{units};
    },

    immobilize => sub {
      $self->{mobile} = 0;
    },

    mobilize => sub {
      $self->{mobile} = 1;
    },

    isMobile => sub {
      return $self->{mobile};
    },

    # Move while changing position
    move => sub {
      my ($cob, $direction, $units) = @_;

      return unless $cob->isMobile();
      my ($x, $y) = $cob->getCoordinates();
      $units = $self->{units} unless defined $units;
      if ($direction eq Arkess::Direction::2D::RIGHT) {
        $cob->setCoordinates($x+$units, $y);
      }
      elsif ($direction eq Arkess::Direction::2D::LEFT) {
        $cob->setCoordinates($x-$units, $y);
      }
      elsif ($direction eq Arkess::Direction::2D::UP) {
        $cob->setCoordinates($x, $y-$units);
      }
      elsif ($direction eq Arkess::Direction::2D::DOWN) {
        $cob->setCoordinates($x, $y+$units);
      }
      else {
        die "Bad direction '$direction'";
      }

      $cob->trigger('move', $direction, $units);
    }

  }
}

1;

__END__
=head1 NAME
Arkess::Component::Mobile - A component for objects that can move around
