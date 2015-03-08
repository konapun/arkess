package AutumnDay::Tile::ParkingLot;

use strict;
use Arkess::Object;
use Arkess::Direction;
use AutumnDay::Item;

sub create {
  my $tile = Arkess::Object->new([
    'AutumnDay::Tile'
  ]);
  my $item = Arkess::Object->new([
    'AutumnDay::Item'
  ]);

  # Build the rooms
  my $tile1 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A dusty parking lot 1.',
      'A dusty parking lot 1.'
    ]
  });
  my $tile2 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A dusty parking lot 2.',
      'A dusty parking lot 2.'
    ]
  });
  my $tile3 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A dusty parking lot 3.',
      'A dusty parking lot 3.'
    ]
  });
  my $tile4 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A dusty parking lot 4.',
      'A dusty parking lot 4.'
    ]
  });

  # Piece the place together
  $tile1->setLink(RIGHT, $tile2);
  $tile1->setLink(DOWN, $tile3);
  $tile2->setLink(DOWN, $tile4);
  $tile3->setLink(RIGHT, $tile4);

  my $gourd = $item->extend({
    'Arkess::Component::Named' => 'gourd',
    'Arkess::Component::Describable' => "A curved, warty gourd. The bottom is a dome of dark green which fades upwards into a light orange as the neck tapers."
  });

  # Add items to rooms
#  $tile1->addEntity($gourd);

  return $tile3;
}

1;
