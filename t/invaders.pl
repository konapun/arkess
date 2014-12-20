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
$game->setWindowOptions({ title => 'Invaders' });


$game->run();
