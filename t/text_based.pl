#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Direction;
use Arkess::IO::Controller;

my $textTile = Arkess::Tile->new({ # prototype for all tiles
  'Arkess::Component::Describable' => "An undescribable area"
});

# Create tiles
my $startingTile = $textTile->clone();
$startingTile->setDescription("the top of a long, rolling hill");

my $valley = $textTile->clone();
$valley->setDescription("a shallow valley");

my $parkingLot = $textTile->clone();
$parkingLot->setDescription("a white gravel parking lot filled with dusty cars");

my $ciderHouse = $textTile->clone();
$ciderHouse->setDescription("a red wooden building with white trim");

# Create entities
my $scarecrow = Arkess::Character->new([ 'Arkess::Component::Describable' ], 'Scarecrow');
$scarecrow->setDescription("A gaunt, sullen looking scarecrow");

# Piece tiles together
print "Before link: startingTile:\n";
print "\tleft\n" if $startingTile->hasLink(LEFT);
print "\tright\n" if $startingTile->hasLink(RIGHT);
print "\tup\n" if $startingTile->hasLink(UP);
print "\tdown\n" if $startingTile->hasLink(DOWN);
print "DONE\n";
$startingTile->setLink(UP, $valley);
print "After setting link UP: startingTile:\n";
print "\tleft\n" if $startingTile->hasLink(LEFT);
print "\tright\n" if $startingTile->hasLink(RIGHT);
print "\tup\n" if $startingTile->hasLink(UP);
print "\tdown\n" if $startingTile->hasLink(DOWN);
print "DONE\n";
#$startingTile->setLink(DOWN, $parkingLot);
#$startingTile->setLink(RIGHT, $ciderHouse);

# Add entities to tiles
$startingTile->addEntity($scarecrow);

# Start!
my $player = Arkess::Character->new([ 'Arkess::Component::Looker' ]);
$player->setPosition($startingTile);

$player->look();
print "DONE\n";
