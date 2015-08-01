package Arkess::Component::DragAndDrop;

use strict;
use Arkess::IO::Mouse;
use Arkess::IO::Mouse::EventType;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Positioned', # To get/set (x, y)
    'Arkess::Component::2D', # To get width/height
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  $self->{controller} = $controller;
  $self->{dragging} = 0;
}

sub setPriority {
  return 2; # need a higher priority than Observable so we can rely on the runtime being set for us to register with
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
    $self->_configureController($controller);
  }
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

  $controller->bind(Arkess::IO::Mouse::EventType::BTN_DOWN, sub {
    my ($cob, $event) = @_;

    # Check to see if click is on a cob with drag and drop enabled
    my $clickX = $event->button_x;
    my $clickY = $event->button_y;
    my ($x, $y) = $cob->getCoordinates();
    my ($width, $height) = $cob->getDimensions();
    print "Clicked ($clickX, $clickY), cob is at ($x, $y) with dimensions ($width, $height)\n";
    if ($clickX >= $x && $clickX < $x + $width && $clickY >= $y && $clickY < $y + $height) { # click was within bounds
      print "CLICKED DRAGGABLE!\n";
      $self->{dragging} = 1;
    }
  });

  $controller->bind(Arkess::IO::Mouse::EventType::MOVE, sub {
    my ($cob, $event) = @_;

    if ($self->{dragging}) {
      my $clickX = $event->button_x;
      my $clickY = $event->button_y;
      my ($width, $height) = $cob->getDimensions();

      $cob->setCoordinates($clickX+$width/2, $clickY+$height/2);
    }
  });

  $controller->bind(Arkess::IO::Mouse::EventType::BTN_UP, sub {
    if ($self->{dragging}) {
      $self->{dragging} = 0;
    }
  });
}

1;

__END__
=head1 NAME
Arkess::Component::DragAndDrop - A component to allow a cob to be moved with the
mouse
