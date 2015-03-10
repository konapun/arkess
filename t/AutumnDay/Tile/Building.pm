package AutumnDay::Tile::Building;

use strict;
use Arkess::Object;
use Arkess::Direction;
use AutumnDay::Item;
use AutumnDay::Fixture;

sub create {
  my $tile = Arkess::Object->new([
    'AutumnDay::Tile'
  ]);
  my $item = Arkess::Object->new([
    'AutumnDay::Item'
  ]);
  my $fixture = Arkess::Object->new([
    'AutumnDay::Fixture'
  ]);

  # Build the rooms
  my $entrance = $tile->extend({
    'Arkess::Component::Describable' => [
      'The shop entrance. Warm, yellow light pours in through the large white-trimmed windows.',
      'The shop entrance.'
    ]
  });

  my $checkoutRegister = $tile->extend({
    'Arkess::Component::Describable' => [
      'A checkout register. Behind the counter is a plump, older woman with a cheerful smile.',
      'A checkout register.'
    ]
  });

  my $store = $tile->extend({
    'Arkess::Component::Describable' => [
      'The shopping area of the store. You see other customers examining various wares. In front of you are wooden shelves with a variety of items.',
      'The shopping area of the store.'
    ]
  });

  # Piece the place together
  $entrance->setLink(UP, $checkoutRegister);
  $checkoutRegister->setLink(UP, $store);

  # Create items
  my $cider = $item->extend({
    'Arkess::Component::Named' => 'cider',
    'Arkess::Component::Describable' => "A medium-sized jug of golden apple cider. You can see carbonation trickling up from the bottom of the jug"
  });
  my $gourd = $item->extend({
    'Arkess::Component::Named' => 'gourd',
    'Arkess::Component::Describable' => "A curved, warty gourd. The bottom is a dome of dark green which fades upwards into a light orange as the neck tapers.",
    'Arkess::Component::Conversable' => []
  });
  $cider->addAction('drink', sub {
    #if ($cider->)
    print "DRINKING\n";
    $cider->destroy();
  });
  $cider->addAction('throw', sub {
    $cider->setName("bottle");
    $cider->setDescription("A broken cider bottle.");

    my $tile = $cider->getPosition();
    $tile->setDescription($tile->getDescription() . " A sticky puddle of cider and broken glass is on the ground");
    $tile->addEntity($cider);
    $cider->getHolder()->removeFromInventory($cider);
  });

  $gourd->whenTalkingTo('Kid')->converse({
    greetings => ['Behold!', 'Psst... Hey kid...'],
    goodbyes => ['Nice talking with ya'],
    questions => {
      'What? Who said that?' => {
        "It's me! The great pumpkin!" => {
          "But you look like a gourd!" => {
            "Kid, a pumpkin is a gourd..." => {
              "Oh yeah..."
            }
          }
        }
      },
      'Are you edible?' => 'NO!',
      'Give me a random number' => sub {
        return rand(100);
      }
    }
  });

  # Add items to rooms
  $store->addEntity($cider);
  $store->addEntity($gourd);

  # Events
  my $paid = 0;
  $entrance->on('addEntity', sub {
    my $entity = shift;

    my @inventory = $entity->listInventory();
    if (scalar @inventory > 0) {
      print "You gotsta pay for that\n";
    }
  });
  $entrance->on('setLink', sub {
    my $direction = shift;

    if ($direction eq LEFT) {
      $entrance->getLink(LEFT)->on('addEntity', sub {
        if (!$paid) {
          print "Did you steal that?\n";
        }
      });
    }
  });

  return $entrance;
}

1;
