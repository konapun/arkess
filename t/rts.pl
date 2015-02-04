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
my $defaultUnit = $game->createEntity({
  'Arkess::Component::Image' => './assets/characters/beetle.png',
  'Arkess::Component::D4' => [],
  'Arkess::Component::CameraFollow' => [$background, 'scroll']
});

$game->setWindowOptions({
  title  => 'Sample Realtime Strategy',
  width  => 512,
  height => 512
});

print "Running\n";
$game->run();
