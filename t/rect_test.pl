#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Keyboard;
use Arkess::Runtime;

my $game = Arkess::Runtime->new();

my $bg = $game->createEntity([
  'Arkess::Component::Background'
]);

my $rect = $game->createEntity({
  'Arkess::Component::Rectangle' => [[300, 300, 200, 200]]
});

my $line = $game->createEntity({
  'Arkess::Component::Line' => [[0, 0], [200, 200]]
});

my $circle = $game->createEntity({
  'Arkess::Component::Circle'
});

my $timer = $game->createEntity({
  'Arkess::Component::Timed' => [10_000, 0]
});

$timer->registerTimedEvent(sub {
  #$game->stop();
});

my $lineController = $game->createController($line, {
  Arkess::IO::Keyboard::KB_UP => sub {
    my $line = shift;

    my $r = int(rand(255));
    my $g = int(rand(255));
    my $b = int(rand(255));
    my $a = int(rand(255));
    $line->setColor([$r, $g, $b, $a]);
  },
  Arkess::IO::Keyboard::KB_LEFT => sub {
    my $line = shift;

    my ($x, $y) = $line->getFrom();
    my ($x2, $y2) = $line->getTo();

    $line->setFrom($x2, $y2);
    $line->setTo($x2-10, $y2-10);
  },
  Arkess::IO::Keyboard::KB_RIGHT => sub {
    my $line = shift;

    my ($x, $y) = $line->getFrom();
    my ($x2, $y2) = $line->getTo();

    $line->setFrom($x2, $y2);
    $line->setTo($x2+10, $y2+10);
  }
});

my $rectController = $game->createController($rect, {
  Arkess::IO::Keyboard::KB_UP => sub {
    my $rect = shift;

    my $r = int(rand(255));
    my $g = int(rand(255));
    my $b = int(rand(255));
    my $a = int(rand(255));
    $rect->setColor([$r, $g, $b, $a]);
  }
});

my $circleController = $game->createController($circle, {
  Arkess::IO::Keyboard::KB_UP => sub {
    my $circle = shift;

    my $r = int(rand(255));
    my $g = int(rand(255));
    my $b = int(rand(255));
    my $a = int(rand(255));
    $circle->setColor([$r, $g, $b, $a]);
  }
});

$game->run();
print "DONE\n";
