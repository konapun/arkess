#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;
use Test::Aged;
use Test::Named;

my $konapun = Arkess::Object->new({
  'Test::Aged' => 80,
  'Test::Named' => 'Konapun',
  'Arkess::Component::Observable' => []
});

$konapun->before('setAge', sub {
  print "Before setting age, " . $konapun->getName() . "'s age was " . $konapun->getAge() . "\n";
});
$konapun->on('setAge', sub {
  print "Set age to " . $konapun->getAge() . "\n";
});

$konapun->setAge(28);

my $babyKonapun = $konapun->extend({
  'Test::Aged' => 1,
  'Test::Named' => 'Konapun (baby form)',
  'Arkess::Component::Observable' => []
});

$babyKonapun->before('setAge', sub {
  print "Before setting age, " . $babyKonapun->getName() . "'s age was " . $babyKonapun->getAge() . "\n";
});
$babyKonapun->on('setAge', sub {
  print "Set age to " . $babyKonapun->getAge() . "\n";
});

$babyKonapun->setAge(2);
