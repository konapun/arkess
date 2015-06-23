package Arkess::Component::3D::Point;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D::Point'
  ];
}

sub setPriority {
  return 3; # above Point::2D
}

sub initialize {
  my ($self, $x, $y, $z) = @_;

  $x ||= 0;
  $y ||= 0;
  $z ||= 0;
  $self->{x} = $x;
  $self->{y} = $y;
  $self->{z} = $z;
}

sub exportMethods {
  my $self = shift;

  return {

    setCoordinates => sub {
      my ($cob, $x, $y, $z) = @_;

      $cob->setX($x);
      $cob->setY($y);
      $cob->setZ($z);
    },

    getZ => sub {
      return $self->{z};
    },

    getCoordinates => sub {
      return ($cob->getX(), $cob->getY(), $cob->getZ());
    }

  };
}

1;
