package Arkess::Component::Circle;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::2D',
    'Arkess::Component::Positioned'
  ];
}

sub initialize {
  my ($self, $origin, $radius, $color) = @_;

  $origin = [20, 20] unless defined $origin;
  $radius = 20 unless defined $radius;
  $color = [255, 255, 0, 255] unless defined $color;
  $self->{origin} = $origin;
  $self->{radius} = $radius;
  $self->{color} = $color;
}

sub exportMethods {
  my $self = shift;

  return {

    getOrigin => sub {
      return shift->{origin};
    },

    getRadius => sub {
      return shift->{radius};
    },

    setOrigin => sub {
      my ($cob, $x, $y) = @_;

      $cob->setCoordinates($x, $y);
    },

    setRadius => sub {
      my ($cob, $r) = @_;

      $self->{radius} = $r;
    },

    setColor => sub {
      my ($cob, $color) = @_;

      $self->{color} = $color;
    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_circle_filled([$cob->getCoordinates()], $self->{radius}, $self->{color});
    }

  };
}

1;
