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

  # Build the rooms
  my $mainRoom = $tile->extend({
    'Arkess::Component::Describable' => [
      'The test room. This room is a playground for testing all kinds of features',
      'The test room.'
    ]
  });
  my $lockedRoom = $tile->extend({
    'Arkess::Component::Describable' => [
      'A locked room.'
    ],
    'Arkess::Component::Attributed' => {
      locked => 1,
      open   => 0
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

  # Piece the place together
  $mainRoom->setLink(LEFT, $lockedRoom);

  # Create items

  # Add items to rooms

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
