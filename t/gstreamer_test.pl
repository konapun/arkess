#!/usr/bin/perl

use strict;
use Cwd qw(abs_path);
use File::Basename;
use GStreamer -init;

my $location = dirname(abs_path($0));
my $file =  $location . '/assets/sounds/Lon-Lon-Ranch.mp3';
print "File: $file\n";
die "No such file $file" unless -e $file;

my $loop = Glib::MainLoop -> new();

# set up
my $play = GStreamer::ElementFactory -> make("playbin", "play");
$play -> set(uri => Glib::filename_to_uri $file, "localhost");
$play -> get_bus() -> add_watch(\&my_bus_callback, $loop);
$play -> set_state("playing");

# run
$loop -> run();

# clean up
$play -> set_state("null");

sub my_bus_callback {
  my ($bus, $message, $loop) = @_;

  if ($message -> type & "error") {
    warn $message -> error;
    $loop -> quit();
  }

  elsif ($message -> type & "eos") {
    $loop -> quit();
  }

  # remove message from the queue
  return 1;
}

while (1) {
  print "Running\n";
  sleep 1;
}
