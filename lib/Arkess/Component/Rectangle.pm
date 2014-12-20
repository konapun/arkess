package Arkess::Component::Rectangle;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $dimensions, $color) = @_;

  $dimensions = [0, 0, 100, 100] unless defined $dimensions;
  $color = [255,255, 0, 255] unless defined $color;
  $self->{dimensions} = $dimensions;
  $self->{color} = $color;
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
      $app->draw_rect($self->{dimensions}, $self->{color});
    }

  };
}

1;
