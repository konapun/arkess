package Arkess::Component::Clickable;

use strict;
use Arkess::Event::Bus;
use Arkess::IO::Mouse;
use Arkess::IO::Mouse::EventType;
use base qw(Arkess::Component);

sub requires {
  my ($self, $requires) = @_;

  return [
    'Arkess::Component::Observable',
    'Arkess::Component::2D', #To get width/height
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  $self->{controller} = $controller;
  $self->{events} = Arkess::Event::Bus->new();
}

sub finalize {
  my ($self, $cob) = @_;

  if (!$self->{controller}) {
    $cob->whenRuntimeAvailable(sub {
      my $runtime = $cob->getRuntime();
      my $controller = $runtime->createController();
      $controller->setPlayer($cob);
      $self->{controller} = $controller;
      $self->_configureController($controller);
    });
  }
  else {
    $self->_configureController($self->{controller});
  }
}

sub exportAttributes {
  return {
    clickable => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {

    getController => sub {
      return $self->{controller};
    },

    onClick => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('click', $sub);
    },

    onUnclick => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('unclick', $sub);
    },

    onMouseMove => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('mousemove', $sub);
    }

  };
}

sub _configureController {
  my ($self, $controller) = @_;

  $controller->bind(Arkess::IO::Mouse::EventType::BTN_DOWN, sub {
    my ($cob, $event) = @_;

    $self->{events}->trigger('click', $event);
  });
  $controller->bind(Arkess::IO::Mouse::EventType::BTN_UP, sub {
    my ($cob, $event) = @_;

    $self->{events}->trigger('unclick', $event);
  });
  $controller->bind(Arkess::IO::Mouse::EventType::MOVE, sub {
    my ($cob, $event) = @_;

    $self->{events}->trigger('mousemove', $event);
  });
}

1;

__END__
=head1 NAME
Arkess::Component::Clickable - A component that allows an object to respond to
clicks
