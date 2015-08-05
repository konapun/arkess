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

  #FIXME - rewrite using Clickable's onDrag event
  my ($offsetX, $offsetY) = (0, 0);
  $cob->onClick(sub {
    my $event = shift;

    # Get click offset
    my ($clickX, $clickY) = ($event->button_x, $event->button_y);
    my ($x, $y) = $cob->getCoordinates();

    $offsetX = $clickX - $x;
    $offsetY = $clickY - $y;
    $self->{dragging} = 1;
  });
  $cob->onUnclick(sub {
    $self->{dragging} = 0;
  });
  $cob->onMouseMove(sub {
    my $event = shift;

    if ($self->{dragging}) {
      my $clickX = $event->button_x;
      my $clickY = $event->button_y;

      $cob->setCoordinates($clickX-$offsetX, $clickY-$offsetY);
    }
  });
}

1;

__END__
=head1 NAME
Arkess::Component::DragAndDrop - A component to allow a cob to be moved with the
mouse
