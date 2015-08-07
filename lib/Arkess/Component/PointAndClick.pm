package Arkess::Component::PointAndClick;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Clickable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D'
  ];
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->boundClickToObject(0);
  $cob->onClick(sub {
    my $event = shift;

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
Arkess::Component::PointAndClick - A component to allow a cob to be moved by
clicking a position on the screen
