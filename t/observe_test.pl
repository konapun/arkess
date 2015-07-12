#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $obj = Arkess::Object->new({
  'Test::Named' => 'named',
  'Arkess::Component::Observable',
});
my $obj2 = $obj->extend({
  'Test::Aged'  => 120,
  'Arkess::Component::Observable',
});
my $obj3 = $obj2->extend({
  'Test::Weighted'  => 100,
#  'Arkess::Component::Observable',
});

my $cnt = 1;
$obj2->on('getName', sub {
  print "Getting name ($cnt)\n";
  $cnt++;
});
$obj2->getName();
print "DONE\n";
