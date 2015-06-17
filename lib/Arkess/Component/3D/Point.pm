package Arkess::Component::Point::2D;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Point::3D'
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

      $self->setX($x);
      $self->setY($y);
      $self->setZ($z);
    },

    getZ => sub {
      return $self->{z};
    },

    getCoordinates => sub {
      return ($self->getX(), $self->getY(), $self->getZ());
    }

  };
}

1;
