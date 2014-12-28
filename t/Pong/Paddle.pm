package Pong::Paddle;

use strict;
use Arkess::Direction;
use Arkess::IO::Keyboard;
use SDL::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned',
    'Arkess::Component::Renderable', # FIXME: Allow initializing in require
    'Arkess::Component::Mobile',
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

  $self->{color} = [255, 255, 0, 255];
  $self->{thickness} = 10;
  $self->{width} = 100;
  $self->{controller} = $controller;
  $self->{position} = $position;
  $self->{moveIncrement} = 20;
}

sub exportMethods {
  my $self = shift;

  my $position = $self->{position};
  my $rect = $self->{rect};

  return {

    move => sub {
      my ($cob, $dir) = @_;

      my $moveIncrement = $self->{moveIncrement};
      if ($dir eq Arkess::Direction::UP) {
        $cob->setY($cob->getY() - $moveIncrement);
      }
      elsif ($dir eq Arkess::Direction::DOWN) {
        $cob->setY($cob->getY() + $moveIncrement);
      }

      $self->{color} = [int(rand(256)), int(rand(256)), int(rand(256)), 255]
    },

    render => sub {
      my $cob = shift;
      my $app = $cob->getRenderer();

      my $x;
      my $y = $cob->getY();
      if ($position eq Arkess::Direction::RIGHT) {
        $x = $app->w - $self->{thickness};
      }
      else {
        $x = 0;
      }

      my $width = $self->{width};
      $app->draw_rect([$x, $y + $width, $self->{thickness}, $width], $self->{color});
    }
  }
}

sub afterInstall {
  my ($self, $owner) = @_;

  $self->{controller}->setPlayer($owner);
}

1;
