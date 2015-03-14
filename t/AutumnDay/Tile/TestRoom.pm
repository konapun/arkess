package AutumnDay::Tile::TestRoom;

use strict;
use Arkess::Object;
use Arkess::Direction;
use AutumnDay::Item;

sub create {
  # Prototypes
  my $tile = Arkess::Object->new([
    'AutumnDay::Tile',
#    'Arkess::Component::Observable'
  ]);
  my $item = Arkess::Object->new([
    'AutumnDay::Item'
  ]);
  my $fixture = Arkess::Object->new([
    'AutumnDay::Fixture'
  ]);
  my $roomWithDoor = $tile->extend({
    'Arkess::Component::Attributed' => {
      'open' => 0,
      'locked' => 0
    },
    'Arkess::Component::Actioned' => {
      unlock => sub {
        my $self = shift;

        $self->{locked} = 0;
      },
      open => sub {
        my $self = shift;

        $self->{open} = 1;
      }
    }
  });
  $roomWithDoor->before('addEntity', sub { # TODO: This should be inherited by everything that extends it
    my $self = shift;

    print "BEFORE - with door\n";
  });

  # Build the rooms
  my $mainRoom = $tile->extend({
    'Arkess::Component::Describable' => [
      'The test room. This room is a playground for testing all kinds of features',
      'The test room.'
    ]
  });
  my $lockedRoom = $roomWithDoor->extend({
    'Arkess::Component::Describable' => [
      'A locked room.'
    ]
  });
  $lockedRoom->before('addEntity', sub {
    my $entity = shift;

    print "Adding entity $entity\n";
    print "BEFORE - locked\n";
  });

  # Piece the place together
  $mainRoom->setLink(LEFT, $lockedRoom);

  # Create decorations for rooms
  my $chest = $fixture->extend({
    'Arkess::Component::Named' => 'chest',
    'Arkess::Component::Describable' => [
      'A wooden chest'
    ],

  });

  # Create items
  my $shirt = $item->extend({
    'Arkess::Component::Named' => 'shirt',
    'Arkess::Component::Describable' => [
      'A blue button-down shirt.'
    ]
  });

  # Add items to rooms
  $chest->addEntity($shirt);
  $mainRoom->addEntity($chest);

  # Add events
  $mainRoom->on('addEntity', sub {
    print "ADDING\n";
  });
  $lockedRoom->before('addEntity', sub {
    if ($lockedRoom->getAttribute('locked')) {
      print "Can't go there\n";
      return 1; # 1 to cancel call
    }
  });

  return $mainRoom;
}

1;
