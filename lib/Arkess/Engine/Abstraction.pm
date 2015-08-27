package Arkess::Engine::Abstraction;

use strict;

sub new {
  my $package = shift;
  my $driver = shift;

  return bless {
    driver => $driver
  }, $package;
}


1;
