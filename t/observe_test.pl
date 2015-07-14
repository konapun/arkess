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
#  'Test::NameConflict' => 'obj2', # FIXME: a name conflict will make it so a rewrap doesn't occur. This is incorrect behavior
  'Test::Named' => 'named2', # FIXME: this breaks the getName trigger
  'Arkess::Component::Observable',
});

my $cnt = 1;
$obj2->on('getName', sub {
  my $name = shift;

  print "Getting name ($cnt): $name\n";
  $cnt++;
});
$obj2->getName();
print "DONE\n";
