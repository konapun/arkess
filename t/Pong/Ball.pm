package Pong::Ball;

use strict;
use SDLx::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
#    'Arkess::Component::Rectangle',
    'Arkess::Component::Collidable'
  ];
}

sub initialize {
  my ($self, $position) = @_;

  $position ||= 0; # FIXME: middle of screen
  $self->{rect} = SDLx::Rect->new(10, 10, 0, 0);
  $self->{v_x} = -2.7;
  $self->{v_y} = 1.8;
  $self->{position} = $position;
}

sub exportMethods {
  my $self = shift;

  my $position = $self->{position};
  my $rect = $self->{rect};
  return {

    move => sub {
      my ($cob, $dir) = @_;

      my $ypos = $rect->y();
      if ($position == Direction::RIGHT) {
        $rect->x($re)
      }
      else {

      }
      $rect->y()
    },

    render => sub {
      print "Rendering ball!\n";
    }
  }
}

1;
