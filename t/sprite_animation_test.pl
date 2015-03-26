#!/usr/bin/perl
use strict;
use lib '../lib';
use Arkess;

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

my $sprite = $game->createEntity({
  'Arkess::Component::AnimatedSprite' => ['./assets/characters/ryu-sprite.png', [7, 6], 100],
  'Arkess::Component::Mobile' => [10],
  'Arkess::Component::PointAndClick' => [],
  'Arkess::Component::D4' => [],
});
$sprite->addAnimationSequences({
  left => [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]],
  up   => [[4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7]]
});
$sprite->setSequence('up');
$game->setWindowOptions({
  title  => 'Sprite Test',
  width  => $background->getWidth(),
  height => $background->getHeight()
});
$game->run();
