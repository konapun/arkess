#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Direction;
use Arkess::IO::Controller;

my $textTile = Arkess::Tile->new({ # prototype for all tiles
  'Arkess::Component::TextBased::Describable' => "An undescribable area"
});
$textTile->setDescription("Text tile!");

# Create tiles
my $startingTile = $textTile->clone(); # FIXME: Make sure clone has set caller for all components from parent
$startingTile->setDescription("the top of a long, rolling hill. At the bottom you see a hay bale maze.");

my $valley = $textTile->clone();
$valley->setDescription("a shallow valley");

my $parkingLot = $textTile->clone();
$parkingLot->setDescription("a white gravel parking lot filled with dusty cars");

my $ciderHouse = $textTile->clone();
$ciderHouse->setDescription("a red wooden building with white trim");

# Create entities
my $scarecrow = Arkess::Character->new([ 'Arkess::Component::TextBased::Describable' ], 'Scarecrow');
$scarecrow->setDescription("A gaunt, sullen looking scarecrow");

# Piece tiles togethe
$startingTile->setLink(UP, $valley);
$valley->setLink(RIGHT, $ciderHouse);

#$startingTile->setLink(DOWN, $parkingLot);
#$startingTile->setLink(RIGHT, $ciderHouse);

# Add entities to tiles
$startingTile->addEntity($scarecrow);

# Start!
my $player = Arkess::Character->new([ 'Arkess::Component::TextBased::Looker' ]);
$player->setPosition($startingTile);

print "Manually getting desc for startingTile ($startingTile)\n";
print $startingTile->getDescription() . "\n";

print "Before look\n";
$player->look();
print "DONE\n";

$player->on('move', sub {
  print "MOVING!\n";
});
$player->move(LEFT);
print "Move done\n";
$player->look();

print "Starting tile: " . $startingTile->getDescription() . "\n";
