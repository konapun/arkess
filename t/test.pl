#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $char = Arkess::Character->new();
print "Character has name attribute\n" if $char->hasAttribute('name');
print "DONE!\n";
