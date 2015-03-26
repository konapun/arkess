package Arkess::Component::Positioned;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $x, $y, $direction) = @_;

  $self->{x} = defined $x ? $x : 0;
  $self->{y} = defined $y ? $y : 0;
  $self->{direction} = defined $direction ? $direction : Arkess::Direction::DOWN;
}

sub exportMethods {
  my $self = shift;

  return {

    setCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $self->{x} = $x;
      $self->{y} = $y;
    },

    setX => sub {
      my ($cob, $x) = @_;

      $self->{x} = $x;
    },

    setY => sub {
      my ($cob, $y) = @_;

      $self->{y} = $y;
    },

    getCoordinates => sub {
      return ($self->{x}, $self->{y});
    },

    getX => sub {
      return $self->{x};
    },

    getY => sub {
      return $self->{y};
    },

    setDirection => sub {
      my ($cob, $direction) = @_;

      $self->{direction} = $direction;
    },

    getDirection => sub {
      return $self->{direction};
    },

    getDistanceFrom => sub {
      my ($cob, $cob2, $abs) = @_;

      die "Can't get distance from unpositioned object" unless $cob2->hasMethod('getDistanceFrom');
      my ($x1, $y1) = $cob->getCoordinates();
      my ($x2, $y2) = $cob2->getCoordinates();
      my $distanceX = $x2 - $x1;
      my $distanceY = $y2 - $y1;
      if ($abs) {
        $distanceX = abs $distanceX;
        $distanceY = abs $distanceY;
      }

      return ($distanceX, $distanceY);
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Positioned - A component for entities who occupy space in the
game world
