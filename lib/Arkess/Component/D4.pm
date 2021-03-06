package Arkess::Component::D4;

use strict;
use Arkess::Event;
use Arkess::IO::Keyboard;
use Arkess::IO::Keyboard::EventType;
use Arkess::Direction::2D;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Mobile',
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $controller, $scheme) = @_;

  $self->{controller} = $controller;
  $self->{direction} = undef;
  $self->{scheme} = defined $scheme ? $scheme : 1;
}

sub setPriority {
  return 2; # need a higher priority than Observable so we can rely on the runtime being set for us to register with
}

sub finalize {
  my ($self, $cob) = @_;

  my $scheme = $self->{scheme};
  if (!$self->{controller}) { # Automatically attach a controller if one has not been explicitly set
    $cob->whenRuntimeAvailable(sub {
      my $runtime = $cob->getRuntime();
      my $controller = $runtime->createController();

      $controller->setPlayer($cob);
      $self->{controller} = $controller;
      if ($scheme == 1) {
        $self->_configureController($controller);
      }
      elsif ($scheme == 2) {
        $self->_configureController2($controller);
      }
      else {
        die "Unknown controller scheme for D4: expected 1 or 2";
      }
    });
  }

  $cob->on(Arkess::Event::TICK, sub {
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
      $self->{direction} = Arkess::Direction::2D::UP;
    },
    Arkess::IO::Keyboard::KB_A => sub {
      $self->{direction} = Arkess::Direction::2D::LEFT;
    },
    Arkess::IO::Keyboard::KB_S => sub {
      $self->{direction} = Arkess::Direction::2D::DOWN;
    },
    Arkess::IO::Keyboard::KB_D => sub {
      $self->{direction} = Arkess::Direction::2D::RIGHT;
    }
  });

  $controller->bind(Arkess::IO::Keyboard::EventType::KEY_UP, sub {
    $self->{direction} = undef;
  });
}

sub _configureController2 {
  my ($self, $controller) = @_;

  $controller->bind({
    Arkess::IO::Keyboard::KB_UP => sub {
      $self->{direction} = Arkess::Direction::2D::UP;
    },
    Arkess::IO::Keyboard::KB_LEFT => sub {
      $self->{direction} = Arkess::Direction::2D::LEFT;
    },
    Arkess::IO::Keyboard::KB_DOWN => sub {
      $self->{direction} = Arkess::Direction::2D::DOWN;
    },
    Arkess::IO::Keyboard::KB_RIGHT => sub {
      $self->{direction} = Arkess::Direction::2D::RIGHT;
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
