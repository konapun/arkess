package AutumnDay::Map;

use strict;
use Arkess::Direction;
#use AutumnDay::Tile::Clearing;
#use AutumnDay::Tile::CornMaze;
use AutumnDay::Tile::ParkingLot;
use AutumnDay::Tile::Building;

sub buildMap {

  my $parkingLot = AutumnDay::Tile::ParkingLot::create();
  my $building = AutumnDay::Tile::Building::create();
  $building->setLink(LEFT, $parkingLot);

  return $building;
}

1;
