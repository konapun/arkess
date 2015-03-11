package AutumnDay::Map;

use strict;
use Arkess::Direction;
#use AutumnDay::Tile::Clearing;
#use AutumnDay::Tile::CornMaze;
use AutumnDay::Tile::ParkingLot;
use AutumnDay::Tile::Building;
use AutumnDay::Tile::Apartment;
use AutumnDay::Tile::TestRoom;

sub new {
  my $package = shift;

  my $self = bless {
    spawnPoint => undef
  }, $package;

  $self->{spawnPoint} = $self->_buildMap();
  return $self;
}

sub getSpawnPoint {
  return shift->{spawnPoint};
}

sub _buildMap {
  my $self = shift;

  my $parkingLot = AutumnDay::Tile::ParkingLot::create();
  my $building = AutumnDay::Tile::Building::create();
  my $apartment = AutumnDay::Tile::Apartment::create();

  $building->setLink(LEFT, $parkingLot);
  $parkingLot->setLink(LEFT, $apartment);

  my $testRoom = AutumnDay::Tile::TestRoom::create();
  return $testRoom;

  return $apartment; # return the spawn point
}

1;
