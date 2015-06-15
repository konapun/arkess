#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;

my $obj = Arkess::Object->new( 'Arkess::Component::RuntimeAdapter' );
$obj->addMethod('greet', sub {
  print "Hello!\n";
});
my $obj2 = Arkess::Object->new({
  'Arkess::Component::NullMethodHolder' => $obj
});
$obj2->nullMethod('greet', 20); # return 20 from greet

print "Obj: " . $obj->greet() . "\n";
print "Obj2: " . $obj2->greet() . "\n";
