package Arkess::Component::DragAndDrop;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Clickable'
  ];
}

sub initialize {
  my $self = shift;

  $self->{dragging} = 0;
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->onClick(sub {
    my $event = shift;

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
  $cob->onUnclick(sub {
    $self->{dragging} = 0;
  });
  $cob->onMouseMove(sub {
    my $event = shift;

    if ($self->{dragging}) {
      my $clickX = $event->button_x;
      my $clickY = $event->button_y;
      my ($width, $height) = $cob->getDimensions();

      $cob->setCoordinates($clickX+$width/2, $clickY+$height/2);
    }
  });
}

1;

__END__
=head1 NAME
Arkess::Component::DragAndDrop - A component to allow a cob to be moved with the
mouse
