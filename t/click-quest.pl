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
  'ClickQuest::UI::Frame' => [700, 500]
});

$game->setWindowOptions({
  title  => 'Click Quest',
  width  => $frame->getWidth(),
  height => $frame->getHeight()
});
$game->run();
