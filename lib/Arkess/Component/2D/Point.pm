package Arkess::Component::2D::Point;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $x, $y) = @_;

  $x ||= 0;
  $y ||= 0;
  $self->{x} = $x;
  $self->{y} = $y;
}

sub exportMethods {
  my $self = shift;

  return {

    setX => sub {
      my ($cob, $x) = @_;

      $self->{x} = $x;
    },

    setY => sub {
      my ($cob, $y) = @_;

      $self->{y} = $y;
    },

    setCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $cob->setX($x);
      $cob->setY($y);
    },

    getX => sub {
      return $self->{x};
    },

    getY => sub {
      return $self->{y};
    },

    getCoordinates => sub {
      my $cob = shift;

      return ($cob->getX(), $cob->getY());
    }

  };
}

1;
