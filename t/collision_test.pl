#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;

my $game = Arkess::Runtime->new({
  title => 'Collision Test'
});

my $collider1 = Arkess::Object->new({
  'Arkess::Component::Collidable' => undef,
  'Arkess::Component::2D::Rectangle' => undef,
  'Arkess::Component::D4' => undef
});
my $collider2 = Arkess::Object->new({ # TODO: Fix clone
  'Arkess::Component::D4' => [undef, 2],
  'Arkess::Component::Collidable' => [],
  'Arkess::Component::2D::Rectangle' => undef,
});
my $collider3 = Arkess::Object->new({
  'Arkess::Component::D4' => [undef, 2],
  'Arkess::Component::Collidable' => [],
  'Arkess::Component::2D::Rectangle' => undef,
});

$collider1->setColor([0,255,0,255]);
$collider2->setColor([0, 0, 255, 255]);
$collider3->setColor([255, 255, 0, 0]);

$collider1->setCollisionTag('collider1');
$collider2->setCollisionTag('collider2');
$collider3->setCollisionTag('collider3');

$collider2->setCoordinates(200, 0);
$collider3->setCoordinates(0, 200);

$collider1->onCollideWith('collider2', sub {
  print "Collider1 collided with collider2\n";
  $collider1->setColor([int(rand(256)), int(rand(256)), int(rand(256)), 255]);
  $collider2->setColor([int(rand(256)), int(rand(256)), int(rand(256)), 255]);
});
$collider1->onCollideWith('collider3', sub {
  print "Collider1 collided with collider3\n";
  $collider1->setColor([int(rand(256)), int(rand(256)), int(rand(256)), 255]);
  $collider3->setColor([int(rand(256)), int(rand(256)), int(rand(256)), 255]);
});

$collider1->onUncollideWith('collider2', sub {
  #die "COLLIDE OFF (1 with 2)";
  print "COLLIDE OFF!\n";
});

$game->createController()->bind(Arkess::IO::Keyboard::KB_SPACE, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  print "Pressed space\n";
});

$game->createEntity({
  'Arkess::Component::Background'
});
$game->addEntity($collider1);
$game->addEntity($collider2);
$game->addEntity($collider3);

$game->run();
