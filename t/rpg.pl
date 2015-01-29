;#!/usr/bin/perl
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
  'Arkess::Component::Image' => './assets/backgrounds/light_world.png',
  'Arkess::Component::D4' => []
});
$background->setSpeed(3);

$game->setWindowOptions({
  title  => 'Sample RPG',
  width  => 800,
  height => 600
});

print "Running\n";
$game->run();
