package Arkess::Component::Background;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $color) = @_;

  $color = [0, 0, 0, 255] unless defined $color; # default black background
  $self->{color} = $color;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_rect([0, 0, $app->w, $app->h], $self->{color});
    }
  };
}

1;
