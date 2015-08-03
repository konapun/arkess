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

my $frame = $game->createEntity({
  'ClickQuest::UI::Frame'
});

$game->setWindowOptions({
  title  => 'Click Quest',
  width  => 1000,
  height => 700
});
$game->run();
