#!/usr/bin/perl

use strict;

use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime::InteractiveFiction;

my $textTile = Arkess::Object->new([
  'Arkess::Component::Describable',
  'Arkess::Component::Linked',
  'Arkess::Component::EntityHolder'
]);

# Create tiles
my $startingTile = $textTile->extend({
  'Arkess::Component::Describable' => "the top of a long, rolling hill. At the bottom you see a hay bale maze."
});
my $valley = $textTile->extend({
  'Arkess::Component::Describable' => "a shallow valley."
});

my $parkingLot = $textTile->extend({
  'Arkess::Component::Describable' => "a white gravel parking lot filled with dusty cars."
});

my $ciderHouse = $textTile->extend({
  'Arkess::Component::Describable' => "a red wooden building with white trim."
});

# Create entities
my $scarecrow = Arkess::Object->new({
  'Arkess::Component::Named' => "Scarecrow",
  'Arkess::Component::Describable' => "A gaunt, sullen looking scarecrow"
});
my $jackolantern = Arkess::Object->new({
  'Arkess::Component::Named' => "Jackolantern",
  'Arkess::Component::Describable' => "An All Hallows Eve favorite"
});

# Piece tiles together
$startingTile->setLink(UP, $valley);
$startingTile->setLink(DOWN, $parkingLot);
$startingTile->setLink(RIGHT, $ciderHouse);
$valley->setLink(RIGHT, $ciderHouse);

# Add entities to tiles
$startingTile->addEntity($scarecrow);
$valley->addEntity($jackolantern);

# Set up the player and visible actions from the player API
my $player = Arkess::Object->new([
  'Arkess::Component::Looker',
  'Arkess::Component::EntityPositioned',
  'Arkess::Component::Actioned',
  'Arkess::Component::InventoryHolder'
]);
$player->addAction('move', sub {
  return $player->move(@_);
});
$player->addAction('look', sub {
  return $player->look(@_);
});
$player->addAction('take', sub {
  my $object = lc shift;

  my $tile = $player->getPosition();
  my @items = $tile->listEntities();
  foreach my $item (@items) {
    if ($item->hasMethod('getName')) {
      if ($object eq lc($item->getName())) {
        $tile->removeEntity($item);
        $player->addToInventory($item);
      }
    }
  }
});
$player->addAction('inventory', sub {
  print "Inventory\n";
  print "---------\n";
  foreach my $item ($player->listInventory()) {
    print "\t" . $item->getName() . "\n";
  }
});
$player->addAction('examine', sub {
  my $object = lc shift;

  foreach my $item ($player->listInventory()) { # First, examine inventory
    if (lc $item->getName() eq $object) {
      print $item->getDescription() . "\n";
      return;
    }
  }

  my $tile = $player->getPosition();
  foreach my $entity ($tile->listEntities()) {
    if (lc $entity->getName() eq $object) {
      print $entity->getDescription() . "\n";
      return;
    }
  }

  print "Can't locate object '$object'\n";
});
$player->addAction('drop', sub {
  my $object = lc shift;

  foreach my $item ($player->listInventory()) {
    if (lc $item->getName() eq $object) {
      my $tile = $player->getPosition();
      $player->removeFromInventory($item);
      $tile->addEntity($item);
      return 1;
    }
  }
  print "Can't locate item '$object' in inventory\n";
});

$player->setPosition($startingTile);

$player->on('move', sub {
  $player->look();
});

# Set up the runtime
my $game = Arkess::Runtime::InteractiveFiction->new();
my $terminal = $game->createController($player);
$terminal->autobind(); # all keys from addAction will be bound to shell commands
$game->run();
