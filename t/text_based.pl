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

# Piece tiles together
$startingTile->setLink(UP, $valley);
$valley->setLink(RIGHT, $ciderHouse);

$startingTile->setLink(DOWN, $parkingLot);
$startingTile->setLink(RIGHT, $ciderHouse);

# Add entities to tiles
$startingTile->addEntity($scarecrow);

# Start!
my $player = Arkess::Object->new([
  'Arkess::Component::Looker',
  'Arkess::Component::EntityPositioned'
]);
$player->setPosition($startingTile);

$player->on('move', sub {
  $player->look();
});

my $game = Arkess::Runtime::InteractiveFiction->new();
$game->run();
