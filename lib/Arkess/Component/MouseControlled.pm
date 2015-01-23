package Arkess::Component::MouseControlled;

use strict;
use Arkess::IO::Mouse;
use Arkess::IO::Mouse::EventType;
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
    $cob->on('setRuntime', sub {
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

  print "CONFIG: $controller\n";
  $controller->bind(Arkess::IO::Mouse::MOUSE_LCLICK, Arkess::IO::Mouse::EventType::BTN_DOWN, sub {
    print "MOUSE CLICK!\n";
  });

  $controller->bind(Arkess::IO::Mouse::EventType::BTN_UP, Arkess::IO::Mouse::EventType::BTN_UP, sub {
    print "UNCLICK!\n";
    $self->{direction} = undef;
  });
}

1;

__END__
=head1 NAME
Arkess::Component::D4 - Default keybindings for a controllable entity
