;#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;
use Arkess::IO::Controller;
use Arkess::IO::Keyboard;
use Arkess::Direction;
use Arkess::Event;
use Arkess::Runtime;

my $game = Arkess::Runtime->new();

my $background = $game->createEntity({
  'Arkess::Component::Image' => './assets/backgrounds/background8/frame-0.png'
});

my @frames;
for my $frame (1 .. 23) {
  push(@frames, "./assets/backgrounds/background8/frame-$frame.png");
}
my $bgAnimations = $game->createEntity({
  'Arkess::Component::AnimatedImage' => [50, @frames]
});
$bgAnimations->setCoordinates(0, 0);

my $fighter1 = $game->createEntity({
  'Arkess::Component::Image' => './assets/characters/ryu1.png',
  'Arkess::Component::Mobile' => [10]
});
#my $fighter1 = $game->createEntity({
#  'Arkess::Component::AnimatedSprite' => './assets/characters/ryu-sprite.png'
#});
#$fighter1->addAnimationSequence('left', )
#$fighter1->addAnimationSequence('right', );
#$fighter1->setAnimationSequence('right');

my $controller = $game->createController($fighter1, {
  Arkess::IO::Keyboard::KB_A => sub {
    $fighter1->move(Arkess::Direction::LEFT);
  },
  Arkess::IO::Keyboard::KB_D => sub {
    $fighter1->move(Arkess::Direction::RIGHT);
  }
});

$game->setWindowOptions({
  title  => 'Fighting Game',
  width  => $background->getWidth(),
  height => $background->getHeight()
});

print "Running\n";
$game->run();
