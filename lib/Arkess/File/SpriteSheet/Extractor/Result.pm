package Arkess::File::SpriteSheet::Extractor::Result;

use strict;

sub new {
  my $package = shift;
  my ($x, $y, $width, $height) = @_;

  return bless {
    x      => $x,
    y      => $y,
    width  => $width,
    height => $height
  }, $package;
}

sub getX {
  return shift->{x};
}

sub getY {
  return shift->{y};
}

sub getWidth {
  return shift->{width};
}

sub getHeight {
  return shift->{height};
}

1;
