#!/usr/bin/perl

use SDLx::Sound;

my $file = './assets/sounds/dialog-warning.ogg';
die "No such file $file" unless -e $file;
my $player = SDLx::Sound->new();
$player->load(
  channel1 => $file
);
for (1 .. 10) {
  $player->play($file);
}
print "DONE\n";

my $snd = SDLx::Sound->new(
  files => (
    chanell_01 => $file,
    chanell_02 => $file
  ),
  loud => (
    channel_01 => 80,
    channel_02 => 75
  ),
  times => (
    chanell_01 => 0,      # start
    chanell_01 => 1256,   # miliseconds
    chanell_02 => 2345
  ),
  fade => (
    chanell_02 => [2345, 3456, -20]
  )
)->play($file);
