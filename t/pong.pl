#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;
use Pong::Paddle;
use Pong::Ball;

my $game = Arkess::Runtime->new();
$game->setWindowOptions({ title => 'Pong' });

# Example of creating your own enity
# NOTE: Do not uncomment this if you're epileptic
#my $background2 = Arkess::Object->new({
#  'Arkess::Component::Background' => [0, 0, 0, 255],
#  'Arkess::Component::Timed' => 50,
#  'Arkess::Component::Observable'
#});
#$background2->on('setRuntime', sub {
#  $background2->registerTimedEvent(sub {
#    $background2->setColor([int(rand(256)), int(rand(256)), int(rand(256)), 255]);
#  });
#});
#$game->addEntity($background2);

my $background = $game->createEntity({
  'Arkess::Component::Background' => [0, 0, 0, 255]
});

my $paddle1 = $game->createEntity({
  'Pong::Paddle' => [$game->createController(), Arkess::Direction::LEFT]
});
my $paddle2 = $game->createEntity({
  'Pong::Paddle' => [$game->createController(), Arkess::Direction::RIGHT]
});
#my $goal1 = $game->createEntity({
#  'Pong::Goal' => Arkess::Direction::LEFT
#});
#my $goal2 = $game->createEntity({
#  'Pong::Goal' => Arkess::Direction::RIGHT
#});
my $ball = $game->createEntity([
  'Pong::Ball'
]);
my $ball2 = $game->createEntity([
  'Pong::Ball'
]);

$game->createController()->bind({
  Arkess::IO::Keyboard::KB_SPACE => sub {
    $game->createEntity([
      'Pong::Ball'
    ]);
  }
});

$game->run();
