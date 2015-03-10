package AutumnDay::Map;

use strict;
use Arkess::Direction;
#use AutumnDay::Tile::Clearing;
#use AutumnDay::Tile::CornMaze;
use AutumnDay::Tile::ParkingLot;
use AutumnDay::Tile::Building;
use AutumnDay::Tile::Apartment;

sub buildMap {

  my $parkingLot = AutumnDay::Tile::ParkingLot::create();
  my $building = AutumnDay::Tile::Building::create();
  my $apartment = AutumnDay::Tile::Apartment::create();
  $building->setLink(LEFT, $parkingLot);

  $parkingLot->setLink(LEFT, $apartment);
  
  return $building;
}

1;
