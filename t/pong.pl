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

my $paddle1 = $game->createEntity({
  'Pong::Paddle' => $game->createController()
});
my $paddle2 = $game->createEntity({
  'Pong::Paddle' => $game->createController()
});

print "Entities created\n";
