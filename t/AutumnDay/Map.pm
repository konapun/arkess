package AutumnDay::Map;

use strict;
#use AutumnDay::Tile::Clearing;
#use AutumnDay::Tile::CornMaze;
#use AutumnDay::Tile::ParkingLot;
use AutumnDay::Tile::Building;

sub buildMap {

  my $building = AutumnDay::Tile::Building::create();
  return $building;
}

1;
