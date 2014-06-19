#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $char = Arkess::Character->new();
print "Character has name attribute\n" if $char->hasAttribute('name');
print "Here1\n";

my $obj = Arkess::Object->new();
print "Here2\n";
$obj->set('test', 'GOT IT!');
print "Here3\n";
print "TEST: " . $obj->get('test') . "\n";

$obj->on('change', sub {
  my ($event, $val) = @_;

  print "GOT CHANGE: $event set val $val\n";
});

$obj->set('test', 'CHANGED YEAH');

#print "Character is facing " . $char->getDirection() . "\n";
print "DONE!\n";
