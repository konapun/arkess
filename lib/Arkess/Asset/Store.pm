package Arkess::Asset::Store;

use strict;

sub new {
  my $package = shift;
  my $assetDirectory = shift;

  return bless {
    dir => $assetDirectory
  }, $package;
}

1;
