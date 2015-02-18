package Arkess::Component::Rectangle;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned',
    'Arkess::Component::2D',
    'Arkess::Component::Renderable'
  ];
}

sub setPriority {
  return 3;
}

sub initialize {
  my ($self, $dimensions, $color) = @_;

  $dimensions = [0, 0, 100, 100] unless defined $dimensions; # (x, y, width, height)
  $color = [255,255, 0, 255] unless defined $color;
  $self->{dimensions} = $dimensions;
  $self->{color} = $color;
}

sub afterInstall {
  my ($self, $cob) = @_;

  my ($x, $y, $width, $height) = @{$self->{dimensions}};
  $cob->setCoordinates($x, $y);
  $cob->setDimensions($width, $height);
}

sub exportMethods {
  my $self = shift;

  return {

    setColor => sub {
      my ($cob, $color) = @_;

      $self->{color} = $color;
    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_rect([$cob->getX(), $cob->getY(), $cob->getWidth(), $cob->getHeight()], $self->{color});
    }

  };
}

1;
