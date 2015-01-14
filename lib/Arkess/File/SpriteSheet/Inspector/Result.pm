package Arkess::File::SpriteSheet::Inspector::Result;

use strict;

sub new {
  my $package = shift;
  my ($self, $xdim, $ydim, spriteWidth, spriteHeight) = @_;

  return bless {
    xdim => $xdim,
    ydim => $ydim,
    spriteWidth => $spriteWidth,
    spriteHeight => $spriteHeight
  }, $package;
}

sub getXDimensions {
  return shift->getNumberOfColumns();
}

sub getYDimensions {
  return shift->getNumberOfRows();
}
sub getNumberOfRows {
  return shift->{ydim};
}

sub getNumberOfColumns {
  return shift->{xdim};
}

sub getSpriteWidth {
  return shift->{spriteWidth};
}

sub getSpriteHeight {
  return shift->{spriteHeight};
}s

1;
