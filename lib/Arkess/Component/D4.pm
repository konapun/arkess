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

sub setPriority {
  return 2; # need a higher priority than Observable so we can rely on the runtime being set for us to register with
}

sub afterInstall {
  my ($self, $cob) = @_;

  if (!$self->{controller}) {
    $cob->on('setRuntime', sub { # FIXME: Sometimes this never gets triggered!
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
      $self->{direction} = 'up';
    },
    Arkess::IO::Keyboard::KB_A => sub {
      $self->{direction} = 'left';
    },
    Arkess::IO::Keyboard::KB_S => sub {
      $self->{direction} = 'down';
    },
    Arkess::IO::Keyboard::KB_D => sub {
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
