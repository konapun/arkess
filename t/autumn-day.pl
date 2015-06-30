#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Direction;
use Arkess::Runtime::InteractiveFiction;
use AutumnDay::Core;

my $game = Arkess::Runtime::InteractiveFiction->new();

my $kid = AutumnDay::Character::Kid::create();
my $map = AutumnDay::Map->new();

$kid->setPosition($map->getSpawnPoint());

$game->addEntity($kid);
my $terminal = $game->createController($kid);
$terminal->autobind();
$terminal->process('alias exit quit');
$terminal->process('look');
$game->run();
