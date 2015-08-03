#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $obj1 = Arkess::Object->new({
  'Test::Named' => 'named',
  'Arkess::Component::Observable' => [],
  'Arkess::Component::MethodChecker' => []
});
my $obj2 = $obj1->extend({
  'Test::Aged'  => 120,
  'Test::NameConflict' => 'obj2', # FIXME: a name conflict will make it so a rewrap doesn't occur. This is incorrect behavior
#  'Test::Named' => 'named2', # FIXME: this breaks the getName trigger
  'Arkess::Component::Observable',
});
my $obj3 = $obj2->extend({
  'Test::Weighted' => 100,
  'Arkess::Component::Observable'
});

if ($obj1->canCall('getName')) {
  print "can working\n";
}
else {
  print "can not working\n";
}
