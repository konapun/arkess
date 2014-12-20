package Pong::Ball;

use strict;
use SDLx::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Collidable'
  ];
}

sub initialize {
  my $self = shift;

  $self->{v_x} = -2.7;
  $self->{v_y} = 1.8;
  $self->{origin} = undef;
  $self->{color} = [255, 255, 255, 255];
  $self->{radius} = 5;
}

sub exportMethods {
  my $self = shift;

  my $position = $self->{position};
  return {

    move => sub {
      my ($cob, $dir) = @_;

    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $self->{origin} = [$app->w/2, $app->h/2] unless defined $self->{origin};
      $app->draw_circle_filled($self->{origin}, $self->{radius}, $self->{color});

      my ($x, $y) = @{$self->{origin}};
      $self->{origin} = [$x-$self->{v_y}, $y];
    }
  }
}

1;
