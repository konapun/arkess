package Arkess::Component::D4;

use strict;
use Arkess::IO::Keyboard;
use Arkess::IO::Keyboard::EventType;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Mobile'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  $self->{controller} = $controller;
  $self->{direction} = undef;
}

sub afterInstall {
  my ($self, $cob) = @_;

  if (!$self->{controller}) {
    $cob->on('setRuntime', sub { # FIXME: Sometimes this never gets triggered!
      print "SET!\n";
      my $runtime = $cob->getRuntime();
      my $controller = $runtime->createController();
      $controller->setPlayer($cob);
      $self->{controller} = $controller;
      $self->_configureController($controller);
    });
  }

  $cob->on(Arkess::Event::LOOP_START, sub {
    my $dir = $self->{direction};
    if ($dir) {
      $cob->move($dir);
    }
  });
}

sub exportMethods {
  my $self = shift;

  return {

    getController => sub {
      return $self->{controller};
    }

  };
}

sub _configureController {
  my ($self, $controller) = @_;

  $controller->bind({
    Arkess::IO::Keyboard::KB_W => sub {
      print "UP!\n";
      $self->{direction} = 'up';
    },
    Arkess::IO::Keyboard::KB_A => sub {
      print "LEFT!\n";
      $self->{direction} = 'left';
    },
    Arkess::IO::Keyboard::KB_S => sub {
      print "DOWN!\n";
      $self->{direction} = 'down';
    },
    Arkess::IO::Keyboard::KB_D => sub {
      print "RIGHT!\n";
      $self->{direction} = 'right';
    },
    Arkess::IO::Keyboard::KB_RIGHT => sub {
      $self->{direction} = 'right';
    },
    Arkess::IO::Keyboard::KB_LEFT => sub {
      $self->{direction} = 'left';
    },
    Arkess::IO::Keyboard::KB_DOWN => sub {
      $self->{direction} = 'down';
    },
    Arkess::IO::Keyboard::KB_UP => sub {
      $self->{direction} = 'up';
    }
  });

  $controller->bind(Arkess::IO::Keyboard::EventType::KEY_UP, sub {
    $self->{direction} = undef;
  });
}

1;

__END__
=head1 NAME
Arkess::Component::D4 - Default keybindings for a controllable entity
