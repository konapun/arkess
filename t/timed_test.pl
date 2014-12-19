#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Runtime;

my $game = Arkess::Runtime->new();

my $timedEntity = $game->createEntity({
  'Arkess::Component::Timed' => 5000, # run every 5 seconds
});

my $event;
my $count = 1;
$event = $timedEntity->registerTimedEvent(sub {
  print "RUNNING ($count of 2)\n";
  if ($count++ >= 2) {
    $event->unregister();
    $game->stop();
  }
});

$timedEntity->registerTimedEvent(sub {
  print "RUNNING ONCE!\n";
}, 4000, 1);

$game->run();

print "DONE\n";
