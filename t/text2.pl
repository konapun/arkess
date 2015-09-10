#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Runtime::InteractiveFiction;

# Protos
my $tile = Arkess::Object->new([
  'Arkess::Component::Linked',
  'Arkess::Component::Describable',
  'Arkess::Component::EntityHolder'
]);
my $character = Arkess::Object->new([
  'Arkess::Component::Looker',
  'Arkess::Component::Named',
  'Arkess::Component::EntityPositioned',
  'Arkess::Component::Actioned',
  'Arkess::Component::Describable'
]);
$character->addAction('test', sub {
  print "TESTING!\n";
});

my $player = $character->extend(); # FIXME Actioned should bring along its shizz

print "PLAYER\n";
$player->callAction('test');
print "CHARACTER\n";
$character->callAction('test');

my $game = Arkess::Runtime::InteractiveFiction->new();
print "Done\n";
