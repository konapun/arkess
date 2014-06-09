#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $char = Arkess::Character->new();
print "Character has name attribute\n" if $char->hasAttribute('name');

my $obj = Arkess::Character->new();
$obj->set('test', 'GOT IT!');
print "TEST: " . $obj->get('test') . "\n";

#print "Character is facing " . $char->getDirection() . "\n";
print "DONE!\n";
