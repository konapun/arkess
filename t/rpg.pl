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
  'Arkess::Component::Image'      => './assets/characters/scarecrow.png',
#  'Arkess::Component::Collidable' => [undef, 'player'],
  'Arkess::Component::D4'         => [],
  'Arkess::Component::CameraFollow' => [$background, 'scroll'],
  'Arkess::Component::Audible' => {
    notification => 'assets/sounds/Shamisen-C4.wav',
    notification2 => 'assets/sounds/Koto.wav'
  }
});
my $beetle = $game->createEntity({
  'Arkess::Component::Image' => './assets/characters/beetle.png',
  'Arkess::Component::Mobile' => [],
  'Arkess::Component::Automated' => []
});
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
my $house = $game->createEntity({
  'RPG::Component::House' => [20, 20]
});

#$player->onCollideWith('house', sub {
#  print "Player collided with house!\n";
#});

$player->getController()->bind(Arkess::IO::Keyboard::KB_SPACE, Arkess::IO::Keyboard::EventType::KEY_DOWN, sub {
  print "Pressed space\n";
  $widget->toggleVisibility();
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

$beetle->addAutomation('cycleSquare', sub {
  my $event;
  $event = $beetle->moveTo(0, 400, sub {
    $beetle->moveTo(400, 400, sub {
      $beetle->moveTo(400, 0, sub {
        $beetle->moveTo(0, 0, sub {
          $event->unregister();
        });
      });
    });
  });
});
$beetle->playAutomation('cycleSquare'); # TODO: Loop animation

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
