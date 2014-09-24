#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::Direction;
use Data::Dumper;

my $proto = Arkess::Character->new(
#{
#  'Arkess::Component::Mortal' => 15
#},
'konapun');
my $konapun = $proto->extend({
  'Arkess::Component::Mortal' => 20
});

print "Proto: $proto\n";
print "Konapun: $konapun\n";
#print "Konapun name: " . $konapun->getName() . "\n";
$proto->takeDamage(2);
print "Proto HP: " . $proto->getHP() . "\n";
print "Konapun HP: " . $konapun->getHP() . "\n";

print Dumper($proto);
print Dumper($konapun);
