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
$startingTile->setDescription("a small clearing");

my $field = $textTile->clone();
$field->setDescription("a mostly barren field");

# Create entities
my $scarecrow = Arkess::Character->new([ 'Arkess::Component::Describable' ], 'Scarecrow');
$scarecrow->setDescription("A gaunt, sullen looking scarecrow");

# Piece tiles together
$startingTile->setLink(RIGHT, $field);

# Add entities to tiles
$startingTile->addEntity($scarecrow);

# Start!
my $player = Arkess::Character->new([ 'Arkess::Component::Looker' ]);
$player->setPosition($startingTile);

$player->look();
print "DONE\n";
