#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;

my $game = Arkess::Runtime->new();

my $background = $game->createEntity({
  'Arkess::Component::BackgroundImage' => './assets/backgrounds/light_world.png'
});
my $player = $game->createEntity({
  'Arkess::Component::Image' => './assets/characters/beetle.png',
  'Arkess::Component::D4' => [],
  'Arkess::Component::CameraFollow' => [$background, 'scroll']
});

my $house = $game->createEntity({
  'RPG::Component::House' => [0, 0]
});

$game->setWindowOptions({
  title  => 'Sample Realtime Strategy',
  width  => 512,
  height => 512
});

$game->run();
