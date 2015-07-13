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
#  'Test::NameConflict' => 'obj2', # FIXME: a name conflict will make it so a rewrap doesn't occur. This is incorrect behavior
  'Arkess::Component::Observable'
});
my $obj3 = $obj2->extend({
  'Test::Weighted'  => 100,
#  'Arkess::Component::Observable',
});

my $cnt = 1;
$obj2->on('getName', sub {
  my $name = shift;

  print "Getting name ($cnt): $name\n";
  $cnt++;
});
$obj2->getName();
print "DONE\n";
