package Pong::Paddle;

use strict;
use Arkess::Direction;
use Arkess::IO::Keyboard;
use SDL::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
#    'Arkess::Component::Rectangle', # FIXME: Allow initializing in require
    'Arkess::Component::Collidable'
  ];
}

sub initialize {
  my ($self, $controller, $position) = @_;

  die "Must provide controller for component Paddle" unless defined $controller;
  die "Must provide position for component Paddle" unless defined $position;
  if ($position eq Arkess::Direction::LEFT) {
    $controller->bind({
      Arkess::IO::Keyboard::KB_W => sub {
        shift->move('up');
      },
      Arkess::IO::Keyboard::KB_S => sub {
        shift->move('down');
      },
    });
  }
  else {
    $position = Arkess::Direction::RIGHT;
    $controller->bind({
      Arkess::IO::Keyboard::KB_UP => sub {
        shift->move('up');
      },
      Arkess::IO::Keyboard::KB_DOWN => sub {
        shift->move('down');
      },
    });
  }

  $self->{rect} = SDL::Rect->new(10, 10, 10, 40);
  $self->{controller} = $controller;
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
      if ($position eq Arkess::Direction::RIGHT) {
        $rect->x(); # TODO
      }
      else {

      }
      $rect->y()
    },

    render => sub {
      if ($position eq Arkess::Direction::RIGHT) {
        print "Rendering paddle right!\n";
      }
      else {
        print "Rendering paddle left!\n";
      }
    }
  }
}

sub afterInstall {
  my ($self, $owner) = @_;

  $self->{controller}->setPlayer($owner);
}

1;
