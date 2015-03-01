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
  'Arkess::Component::Image'      => './assets/characters/beetle.png',
#  'Arkess::Component::Collidable' => [undef, 'player'],
  'Arkess::Component::D4'         => [],
  'Arkess::Component::CameraFollow' => [$background, 'scroll']
});

my $widget = $game->createEntity({
  'Arkess::Component::Widget' => $player
});

my $house = $game->createEntity({
  'RPG::Component::House' => [20, 20]
});

#$player->onCollideWith('house', sub {
#  print "Player collided with house!\n";
#});

$player->getController()->bind(Arkess::IO::Keyboard::KB_SPACE, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  print "Pressed space\n";
});
$game->setWindowOptions({
  title  => 'Sample RPG',
  width  => 512,
  height => 512
});

$game->run();
