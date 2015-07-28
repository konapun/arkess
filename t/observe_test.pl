#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;

my $obj1 = Arkess::Object->new({
  'Test::Named' => 'named',
  'Arkess::Component::Observable',
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

my $cnt = 1;
$obj2->on('getName', sub {
  my $name = shift;

  print "Getting name ($cnt): $name\n";
  $cnt++;
});
$obj2->getName();
print "DONE\n";

my $unwrapped = $obj2->_getUnwrapped();
print "Calling unwrapped version. Shouldn't print\n";
$unwrapped->get('getName')->call();
print "Done (getName should't have printeted before this)\n";

print "Testing unregistering an event\n";
$obj2->dontObserve('getName');
$obj2->setName('testName');
print "Name: " . $obj2->getName() . "\n";

print "Testing reregistering an event\n";
$obj2->observe('getName');
print "Name: " . $obj2->getName() . "\n";
