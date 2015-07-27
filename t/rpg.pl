#!/usr/bin/perl
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
  'Arkess::Component::BackgroundImage' => './assets/backgrounds/light_world.png'
});
my $player = $game->createEntity({
  'Arkess::Component::AnimatedSprite' => ['./assets/characters/link.png', [16, 4], 200],
#  'Arkess::Component::Collidable' => 'player', # Collision tag for player
  'Arkess::Component::D4'         => [],
  'Arkess::Component::CameraFollow' => [$background, 'scroll'],
  'Arkess::Component::Audible' => {
    notification  => 'assets/sounds/Shamisen-C4.wav',
    notification2 => 'assets/sounds/Koto.wav',
    theme         => 'assets/sounds/theme.wav'
  },
  'Arkess::Component::CoordinateZIndex' => []
});
print "MOVING\n";
$player->move(Arkess::Direction::LEFT);
print "Moved\n";
my $partyMember = $game->createEntity({
  'Arkess::Component::AnimatedSprite' => ['./assets/characters/maiden.png', [8, 1], 200],
  'Arkess::Component::Automated' => [],
  'Arkess::Component::CoordinateZIndex' => []
});
my $partyMember2 = $partyMember->extend({
  'Arkess::Component::AnimatedSprite' => ['./assets/characters/maiden2.png', [8, 1], 200],
});
my $partyMember3 = $partyMember->extend({
  'Arkess::Component::AnimatedSprite' => ['./assets/characters/zelda.png', [8, 1], 200],
});
$game->addEntity($partyMember2);
$game->addEntity($partyMember3);
my $widget = $game->createEntity({
  'Arkess::Component::Widget' => {
    visible => 0
  }
});
my $textbox = $game->createEntity({
  'Arkess::Component::TextBox' => [[
    "This is an example of a textbox.Press enter to scroll through the text pages.",
    "This is the second page.",
    "This is a long page to test text wrapping. Widgets will automatically wrap lines while avoiding breaking up words. Eventually, the textbox component should automatically add pages when text exceeds given space. Some extra stuff here to force automatic paging.",
    "After this page, the box will go invisible."
  ]]
});
#my $house = $game->createEntity({
#  'RPG::Component::House' => [20, 20]
#});

#$player->onCollideWith('house', sub {
#  print "Player collided with house!\n";
#});

$partyMember->addAnimationSequences({
  Arkess::Direction::UP    => [[0, 6], [0, 7]],
  Arkess::Direction::DOWN  => [[0, 4], [0, 5]],
  Arkess::Direction::LEFT  => [[0, 0], [0, 1]],
  Arkess::Direction::RIGHT => [[0, 2], [0, 3]]
});
$partyMember->on('move', sub {
  my ($direction, $units) = @_;

  $partyMember->setSequence($direction) if $direction;
});
$partyMember->follow($player);

$partyMember2->addAnimationSequences({
  Arkess::Direction::UP    => [[0, 6], [0, 7]],
  Arkess::Direction::DOWN  => [[0, 4], [0, 5]],
  Arkess::Direction::LEFT  => [[0, 0], [0, 1]],
  Arkess::Direction::RIGHT => [[0, 2], [0, 3]]
});
$partyMember2->on('move', sub {
  my ($direction, $units) = @_;

  $partyMember2->setSequence($direction) if $direction;
});
$partyMember2->follow($partyMember);

$partyMember3->addAnimationSequences({
  Arkess::Direction::UP    => [[0, 4], [0, 5]],
  Arkess::Direction::DOWN  => [[0, 0], [0, 1]],
  Arkess::Direction::LEFT  => [[0, 6], [0, 7]],
  Arkess::Direction::RIGHT => [[0, 2], [0, 3]]
});
$partyMember3->on('move', sub {
  my ($direction, $units) = @_;

  $partyMember3->setSequence($direction) if $direction;
});
$partyMember3->follow($partyMember2, 60);

$player->setZIndex(2);
#$partyMember->setZIndex(3);
#$partyMember2->setZIndex(2);
#$partyMember3->setZIndex(1);
$player->addAnimationSequences({
  Arkess::Direction::UP    => [[3, 0], [3, 1], [3, 2],  [3, 3],  [3, 4],  [3, 5],  [3, 6],  [3, 7]],
  Arkess::Direction::DOWN  => [[3, 8], [3, 9], [3, 10], [3, 11], [3, 12], [3, 13], [3, 14], [3, 15]],
  Arkess::Direction::LEFT  => [[2, 0], [2, 1], [2, 2],  [2, 3],  [2, 4],  [2, 5],  [2, 6],  [2, 7]],
  Arkess::Direction::RIGHT => [[2, 8], [2, 9], [2, 10], [2, 11], [2, 12], [2, 13], [2, 14], [2, 15]]
});
$player->getController()->bind(Arkess::IO::Keyboard::KB_RETURN, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  print "Advancing page\n";
  $textbox->displayNextPage();
#  $textbox->toggleVisibility();
});
$player->getController()->bind(Arkess::IO::Keyboard::KB_1, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  $player->playSound('notification');
});
$player->getController()->bind(Arkess::IO::Keyboard::KB_2, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  $player->playSound('notification2');
});
$player->getController()->bind(Arkess::IO::Keyboard::KB_3, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  $player->playSound('theme');
});
$player->on('move', sub {
  my ($direction, $units) = @_;
  $player->setSequence($direction) if $direction;
});
$partyMember->addAutomation('cycleSquare', sub {
  print "Moving to 0,400\n";
  $partyMember->moveTo(0, 400, sub {
    print "Moving to 400,400\n";
    $partyMember->moveTo(400, 400, sub {
      print "Moving to 400,0\n";
      $partyMember->moveTo(400, 0, sub {
        print "Moving to 0,0\n";
        $partyMember->moveTo(0, 0, sub {
          print "DONE\n";
        });
      });
    });
  });
});
$player->getController()->bind(Arkess::IO::Keyboard::KB_SPACE, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  print "Pressed space\n";
  $partyMember->playAutomation('cycleSquare');
});

$game->setWindowOptions({
  title  => 'Sample RPG',
  width  => 512,
  height => 512
});
my $musicPlayer = Arkess::Sound::Player->new({
  theme => 'assets/sounds/theme.wav'
});
#$musicPlayer->playSound('theme');
$game->run();
