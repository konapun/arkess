package Arkess::Component::Mobile;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned'
  ];
}

sub initialize {
  my ($self, $units) = @_;

  $self->{units} = defined $units ? $units : 1; # How many units to move on strafe or move
}

sub setPriority {
  return 3;
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

    # Move while changing position
    move => sub {
      my ($cob, $direction, $units) = @_;

      my ($x, $y) = $cob->getCoordinates();
      $units = $self->{units} unless defined $units;
      if ($direction eq Arkess::Direction::RIGHT) {
        $cob->setCoordinates($x+$units, $y);
      }
      elsif ($direction eq Arkess::Direction::LEFT) {
        $cob->setCoordinates($x-$units, $y);
      }
      elsif ($direction eq Arkess::Direction::UP) {
        $cob->setCoordinates($x, $y-$units);
      }
      elsif ($direction eq Arkess::Direction::DOWN) {
        $cob->setCoordinates($x, $y+$units);
      }
      else {
        die "Bad direction '$direction'";
      }
      $cob->trigger('move', $direction, $units); # FIXME: shouldn't be necessary
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Mobile - A component for objects that can move around
