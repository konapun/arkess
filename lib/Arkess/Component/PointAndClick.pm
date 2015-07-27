package Arkess::Component::PointAndClick;

use strict;
use Arkess::IO::Mouse;
use Arkess::IO::Mouse::EventType;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  my ($self, $requires) = @_;

  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Mobile',
# FIXME: these shouldn't reset image dimensions
    'Arkess::Component::Positioned', # To get/set (x, y)
    'Arkess::Component::2D' # To get width/height
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  $self->{controller} = $controller;
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
  else {
    $self->_configureController($self->{controller});
  }
}

sub exportAttributes {
  return {
    pointAndClickable => 1
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
    my ($imgX, $imgY) = ($clickX - $width/2, $clickY - $height/2); # Place image center at click point

    $cob->setCoordinates($imgX, $imgY);
  });
}

1;

__END__
=head1 NAME
Arkess::Component::PointAndClick - A component to allow a cob to be moved with
the mouse
