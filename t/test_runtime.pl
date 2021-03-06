#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;

my $runtime = Arkess::Runtime->new();
$runtime->setFPS(60);
$runtime->setWindowOptions({
  title => 'My Game'
});
my $bus = $runtime->getEventBus();
my $controller = $runtime->createController();
my $background = $runtime->createEntity({
  'Arkess::Component::Image' => 'img/map.gif'
});
my $character = $runtime->createEntity({
  'Arkess::Component::Image' => 'img/link.jpg',
  'Arkess::Component::D4' => $controller,
  #'Arkess::Component::Collidable'
});

$character->setEventBus($bus);
$character->on(Arkess::Event::RUNTIME_START, sub {
  print "Character caught start of runtime event!\n";
});

my $loopIndex = 0;
$bus->bind(Arkess::Event::LOOP_START, sub {
  $runtime->stop() if ($loopIndex++ >= 1800);
});
$bus->bind(Arkess::Event::RUNTIME_STOP, sub {
  print "STOPPING\n";
});
$runtime->run();
