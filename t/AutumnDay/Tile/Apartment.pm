package AutumnDay::Tile::Apartment;

use strict;
use Arkess::Object;
use Arkess::Direction;
use AutumnDay::Item;

sub create {
  # Prototypes
  my $tile = Arkess::Object->new([ # Tiles are rooms
    'AutumnDay::Tile',
  ]);
  my $item = Arkess::Object->new([
    'AutumnDay::Item'
  ]);
  my $fixture = Arkess::Object->new([ # Fixtures are items which are not takeable
    'AutumnDay::Fixture'
  ]);

  # Build the rooms
  my $entryway = $tile->extend({
    'Arkess::Component::Describable' => [
      'The apartment entryway. A small area by the front door with a white laminate floor and a narrow hall leading to the next room. A green and orange banner with pumpkin ribbons spelling out "Happy Halloween!" hangs overhead.',
      'The apartment entryway.'
    ]
  });
  my $kitchen = $tile->extend({
    'Arkess::Component::Describable' => [
      'The kitchen. There is a stainless steel sink with a tall counter facing the living room. To the other side of the sink are cabinets, a stove, and a refrigerator. A plastic candelabra sits on the counter.',
      'The kitchen.'
    ]
  });
  my $livingRoom = $tile->extend({
    'Arkess::Component::Describable' => [
      'The living room. A beige carpet covers the floor. There is a large, well-worn blue couch against the wall with a square coffee table in front of it. There is an entertainment center with a plasma television against the wall opposite the couch. A Halloween shrine sits next to the television.',
      'The living room.'
    ]
  });
  my $slidingDoor = $tile->extend({
    'Arkess::Component::Describable' => [
      'A glass sliding door (locked) partially obscured by a tattered black cloth. Peering outside through the door you see a ground level balcony with a white railing.',
      'A glass sliding door.'
    ],
    'Arkess::Component::Named' => 'door',
    'Arkess::Component::Attributed' => {
      open => 0,
      locked => 1
    },
    'Arkess::Component::Actioned' => {
      open => sub {
        my $self = shift;

        if (!$self->getAttribute('locked')) {
          $self->setAttribute('open', 1)
        }
      },
      close => sub {
        my $self = shift;

        $self->setAttribute('open', 0);
      },
      unlock => sub {
        my $self = shift;

        $self->setAttribute('locked', 0);
      },
      lock => sub {
        my $self = shift;

        $self->setAttribute('locked', 1);
      }
    }
  });
  my $hallway = $tile->extend({
    'Arkess::Component::Describable' => [
      'The hallway (1). An intake vent for HVAC is on the ceiling along with a light fixture',
      'The hallway (1).'
    ]
  });
  my $hallway2 = $tile->extend({
    'Arkess::Component::Describable' => [
      'The hallway (2). There is a sconce with a flickering candle bulb on the wall to the right',
      'The hallway (2).'
    ]
  });
  my $bathroom = $tile->extend({
    'Arkess::Component::Describable' => [
      'The bathroom. Immediately in front of you is a counter and sink with a large mirror above it. To your right is a shower and toilet.',
      'The bathroom.'
    ]
  });
  my $bedroom1 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A large bedroom in disarray.',
      'A large bedroom.'
    ]
  });
  my $bedroom1Closet = $tile->extend({

  });
  my $bedroom1Bathroom = $tile->extend({

  });
  my $bedroom2 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A corner bedroom.',
      'A corner bedroom.'
    ]
  });
  my $bedroom2Closet = $tile->extend({
    'Arkess::Component::Describable' => [
      'A closet'
    ]
  });
  my $bedroom3 = $tile->extend({
    'Arkess::Component::Describable' => [
      'A third bedroom.'
    ]
  });
  my $bedroom3Closet = $tile->extend({
    'Arkess::Component::Describable' => [
      'A closet'
    ]
  });

  # Piece the place together
  $entryway->setLink(UP, $livingRoom);
  $entryway->setLink(LEFT, $kitchen);
  $livingRoom->setLink(UP, $slidingDoor);
  $livingRoom->setLink(LEFT, $hallway);
  $hallway->setLink(DOWN, $bathroom);
  $hallway->setLink(LEFT, $bedroom1);
  $hallway->setLink(UP, $hallway2);
  $hallway2->setLink(LEFT, $bedroom2);
  $hallway2->setLink(UP, $bedroom3);
  $bedroom1->setLink(UP, $bedroom1Closet);
  $bedroom1->setLink(DOWN, $bedroom1Bathroom);
  $bedroom2->setLink(DOWN, $bedroom2Closet);
  $bedroom3->setLink(RIGHT, $bedroom3Closet);

  # Create items and decorations
  my $bed = $fixture->extend({
    'Arkess::Component::Named' => 'bed',
    'Arkess::Component::Describable' => [
      'A queensized bed.'
    ]
  });
  my $pillow = $item->extend({
    'Arkess::Component::Named' => 'pillow',
    'Arkess::Component::Describable' => [
      'A fluffly white pillow.',
      'A fluffy white pillow. The pillowcase is a light blue cotton and the pillow is stuffed with down.'
    ]
  });
  $bed->addEntity($pillow->clone());
  $bed->addEntity($pillow->clone());

# $bed->acceptsActions({ sleep => sub{} });
  my $cupboards = $fixture->extend({
    'Arkess::Component::Named' => 'cupboards',
    'Arkess::Component::EntityHolder' => [],
    'Arkess::Component::Describable' => [
      'Brown cupboards'
    ]
  });
  $cupboards->addEntity($item->extend({
    'Arkess::Component::Named' => 'cup',
    'Arkess::Component::Describable' => [
      'A black plastic cup'
    ],
  #  'AutumnDay::Component::LiquidHolder',
    'Arkess::Component::Usable' => sub {
      print "You use the cup\n";
    },
    'Arkess::Component::Actioned' => {
      fill => sub {
        my $liquid = shift;

        print "Filling the cup with $liquid\n";
      }
    }
  }));

  my $refrigerator = $fixture->extend({
    'Arkess::Component::Named' => 'refrigerator',
    'Arkess::Component::Describable' => [
      'A large, white refrigerator.'
    ]
  });
  $refrigerator->addEntity($item->extend({
    'Arkess::Component::Named' => 'milk',
    'Arkess::Component::Describable' => [
      'A gallon of milk.',
      'MILK EXPIRATION DATE'
    ],
    'Arkess::Component::Usable' => sub {
      print "You drink the milk\n";
    }
  }));

  my $tv = $fixture->extend( 'AutumnDay::Item::TV' );

  # Add items and decorations to rooms
  $kitchen->addEntity($cupboards);
  $kitchen->addEntity($refrigerator);
  $bedroom1->addEntity($bed);
  $bedroom2->addEntity($tv);

  $livingRoom->addEntity($fixture->extend( 'AutumnDay::Item::Chest' ));

  # Add events
  $entryway->on('addEntity', sub {
    print "ADDING\n";
  });

  return $entryway;
}

1;
