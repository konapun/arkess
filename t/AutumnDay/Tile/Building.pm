package AutumnDay::Tile::Building;

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

  my $shelves = $tile->extend({
    'Arkess::Component::Describable' => 'Wooden shelves stacked with festive items.'
  });

  # Piece the place together
  $entrance->setLink(UP, $checkoutRegister);
  $checkoutRegister->setLink(UP, $shelves);

  # Create items
  my $cider = $item->extend({
    'Arkess::Component::Named' => 'cider',
    'Arkess::Component::Describable' => "A medium-sized jug of golden apple cider. You can see carbonation trickling up from the bottom of the jug"
  });
  my $gourd = $item->extend({
    'Arkess::Component::Named' => 'gourd',
    'Arkess::Component::Describable' => "A curved, warty gourd. The bottom is a dome of dark green which fades upwards into a light orange as the neck tapers."
  });
  $cider->addAction('drink', sub {
    #if ($cider->)
    $cider->destroy();
  });

  # Add items to rooms
  $shelves->addEntity($cider);
  $shelves->addEntity($gourd);

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
