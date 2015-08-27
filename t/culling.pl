#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;

# Test masking a single-layered image to create the illusion of depth
my $game = Arkess::Runtime->new();
my $background = $game->createEntity({
  'Arkess::Component::BackgroundImage' => 'assets/backgrounds/culling.png',
  'Arkess::Component::Culled' => {
    100 => [
      [0, 200, 120, 145],
      [170, 170, 50, 50],
      [250, 250, 315, 52]
    ]
  }
});
my $character = $game->createEntity({
  'Arkess::Component::Image' => './assets/characters/ryu1.png',
  'Arkess::Component::Mobile' => [1],
  'Arkess::Component::PointAndClick' => [],
  'Arkess::Component::D4' => [],
  'Arkess::Component::DragAndDrop' => [],
});
$character->setZIndex(1);
$game->setWindowOptions({
  title  => 'Culling Test',
  width  => 640,
  height => 400
});
$game->run();
