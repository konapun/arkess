#!/usr/bin/perl

use strict;
use lib '../lib/';
use Arkess::Event::Promise;

sub doSomething {
  return Arkess::Event::Promise->new(sub {
    my ($resolve, $reject) = @_;

    my $value = 42;
    if ($value == 0) {
      $reject->($value);
    }
    else {
      $resolve->($value);
    }
  });
}

sub doSomethingElse {
  return Arkess::Event::Promise->new(sub {
    my $resolve = shift;

    my $value = 69;
    $resolve->($value);
  });
}

my $promise = doSomething();
$promise->then(sub {
  my $value = shift;

  print "Got a value: $value\n";
});
$promise->then(sub {
  my $value = shift;

  print "Got the same value again: $value\n";
});

doSomething()->then(sub {
  my $result = shift;

  print "First result: $result\n";
  return 88;
})->then(sub {
  my $result = shift;

  print "Second result: $result\n";
});

doSomething()->then()->then(sub {
  my $result = shift;

  print "Got a result $result\n";
});

doSomething()->then(sub {
  my $result = shift;

  return doSomethingElse($result);
})->then(sub {
  my $finalResult = shift;

  print "The final result is $finalResult\n";
});

print "\n################\n";
my $resolved = Arkess::Event::Promise->resolve(99);
$resolved->then(sub {
  my $value = shift;

  print "Resolved function with value $value\n";
});
my $rejected = Arkess::Event::Promise->reject("Testing reject");
$rejected->catch(sub {
  my $reason = shift;

  print "Rejected because: $reason\n";
});
