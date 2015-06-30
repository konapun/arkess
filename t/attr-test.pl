#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::Direction;
use Arkess::Runtime::InteractiveFiction;
use AutumnDay::Core;

my $object = Arkess::Object->new( 'Test::AttrTest' );
my $clone = $object->clone( 'Test::AttrTest' => {
  'newAttribute' => 1
});

print "OBJECT: " . ($object->hasAttribute('retainedInitial') ? "YES" : "NO") . "\n";
print "CLONE: " . ($clone->hasAttribute('retainedInitial') ? "YES" : "NO") . "\n";
$clone->attributes->each(sub {
  my ($key, $val) = @_;

  print "$key: $val\n";
});
