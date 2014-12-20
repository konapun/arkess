#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;
use Pong::Paddle;

my $game = Arkess::Runtime->new();
$game->setWindowOptions({ title => 'Pong' });

my $background = $game->createEntity({
  'Arkess::Component::Background' => [0, 0, 0, 255]
});

my $paddle1 = $game->createEntity({
  'Pong::Paddle' => [$game->createController(), Arkess::Direction::LEFT]
});
my $paddle2 = $game->createEntity({
  'Pong::Paddle' => [$game->createController(), Arkess::Direction::RIGHT]
});
my $ball = $game->createEntity([
  'Pong::Ball'
]);

$game->run();
print "Entities created\n";
