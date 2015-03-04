#!/usr/lib/perl

use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;


my $goal = Arkess::Object->new(
  'Arkess::Component::Collidable'
);
my $obstacle = Arkess::Object->new(
  'Arkess::Component::Collidable'
);
my $shooter = Arkess::Object->new(
  'Plinko::Component::Shooter'
);

my $app = Arkess::Runtime->new();
$app->createEntity({
  'Arkess::Component::Background' => []
});
$app->addEntity($shooter);

my $controller = $app->createController($shooter);
$controller->bind(Arkess::IO::Keyboard::KB_SPACE, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  $shooter->shoot();
});

$app->setWindowOptions({
  title  => 'Sample RPG',
  width  => 500,
  height => 800
});
$app->run();
