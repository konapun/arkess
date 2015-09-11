#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess::Event::Promise;

my $promise = Arkess::Event::Promise->new(sub {
  my ($resolve, $reject) = @_;

  if (1) {
    $resolve->('ACCEPT!');
  }
  else {
    $reject->('REJECT!');
  }
})->then(sub {
  print "Promise 2\n";
})->then(sub {
  print "Promise 3\n";
});
