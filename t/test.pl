#!/usr/bin/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::Direction;

my $char = Arkess::Character->new('Kiddo');
print "Character has name attribute: " . $char->getName() . "\n" if $char->hasAttribute('name');

### Test propertiees
my $obj = $char;
$obj->set('test', 'GOT IT!');
print "TEST: " . $obj->get('test') . "\n";

$obj->on('change', sub {
  my ($prop, $val, $oldval) = @_;

  print "GOT CHANGE: $prop set val $val\n" if $prop eq 'watch';
});

$obj->set('test', 'CHANGED YEAH');
$obj->set('watch', 'VISIBLE IF WORKING');

print "Character is facing " . $char->getDirection() . "\n";

$obj->on('die', sub {
  print "Oh no! " . $obj->getName() . " has died!\n";
});
while ($obj->isAlive()) {
  print "Alive: HP at " . $obj->getHP() . "\n";
  $obj->takeDamage();
}

print "DONE!\n";

### Test moving
my $tile = Arkess::Tile->new();
my $mover = Arkess::Character->new('Konapun');
$tile->setLink(RIGHT, Arkess::Tile->new());

$mover->setTile($tile);
print "TILE: " . $mover->getTile() . "\n";
if ($mover->move(RIGHT)) {
  print "Was able to move!\n";
}
else {
  print "Unable to move right\n";
}

print "Can move right? " . $tile->hasLink(RIGHT) . "\n";
print "Can move left? " . $tile->hasLink(LEFT) . "\n";

### Test controller
my $controller = Arkess::IO::Controller->new($mover);
$controller->bind('W', sub {
  print "Mooving up\n";
  shift->move(UP);
});
$controller->bind('A', sub {
  shift->move(LEFT);
});
$controller->bind('S', sub {
  shift->move(DOWN);
});
$controller->bind('D', sub {
  shift->move(RIGHT);
});

$controller->process('W');
