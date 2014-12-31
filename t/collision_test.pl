;#!/usr/bin/perl
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
  'Arkess::Component::Rectangle' => undef,
  'Arkess::Component::Mobile' => [10]
});
my $collider2 = Arkess::Object->new({ # TODO: Fix clone
  'Arkess::Component::Mobile' => [10],
  'Arkess::Component::Collidable' => [],
  'Arkess::Component::Rectangle' => undef,
});
$collider1->setColor([0,255,0,255]);
$collider2->setColor([255, 0, 0, 255]);

#$collider1->setCollisionTag('collider1');
#$collider2->setCollisionTag('collider2');

$collider2->setCoordinates(200, 0);
$game->createController($collider1, {
  Arkess::IO::Keyboard::KB_W => sub {
    $collider1->move(Arkess::Direction::UP);
  },
  Arkess::IO::Keyboard::KB_A => sub {
    $collider1->move(Arkess::Direction::LEFT);
  },
  Arkess::IO::Keyboard::KB_S => sub {
    $collider1->move(Arkess::Direction::DOWN);
  },
  Arkess::IO::Keyboard::KB_D => sub {
    $collider1->move(Arkess::Direction::RIGHT);
  }
});
$game->createController($collider2, {
  Arkess::IO::Keyboard::KB_UP => sub {
    $collider2->move(Arkess::Direction::UP);
  },
  Arkess::IO::Keyboard::KB_LEFT => sub {
    $collider2->move(Arkess::Direction::LEFT);
  },
  Arkess::IO::Keyboard::KB_DOWN => sub {
    $collider2->move(Arkess::Direction::DOWN);
  },
  Arkess::IO::Keyboard::KB_RIGHT => sub {
    $collider2->move(Arkess::Direction::RIGHT);
  }
});

$game->createEntity({
  'Arkess::Component::Background'
});
$game->addEntity($collider1);
$game->addEntity($collider2);

$game->run();
