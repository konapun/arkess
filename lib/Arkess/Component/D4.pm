package Arkess::Component::D4;

use strict;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  die "Must provide controller for component D4" unless defined $controller;
  $self->{controller} = $controller;
  $controller->bind({
    Arkess::IO::Keyboard::KB_W => sub {
      shift->move('up');
    },
    Arkess::IO::Keyboard::KB_A => sub {
      shift->move('left');
    },
    Arkess::IO::Keyboard::KB_S => sub {
      shift->move('down');
    },
    Arkess::IO::Keyboard::KB_D => sub {
      shift->move('right');
    },
    Arkess::IO::Keyboard::KB_RIGHT => sub {
      shift->move('right');
    },
    Arkess::IO::Keyboard::KB_LEFT => sub {
      shift->move('left');
    },
    Arkess::IO::Keyboard::KB_DOWN => sub {
      shift->move('down');
    },
    Arkess::IO::Keyboard::KB_UP => sub {
      shift->move('up');
    }
  });
  $self->{controller} = $controller;
}

sub afterInstall {
  my $self = shift;

  my $owner = $self->getObject();
  $self->{controller}->setPlayer($owner);
}

1;

__END__
=head1 NAME
Arkess::Component::D4 - Default keybindings for a controllable entity
