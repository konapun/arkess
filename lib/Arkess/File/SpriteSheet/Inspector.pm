package Arkess::File::SpriteSheet::Inspector;

use strict;
use GD;
use GD::Image

sub new {
  my $package = shift;

  return bless {}, $package;
}

sub inspect {
  my ($self, $src) = @_;

  my $gdImage = GD::Image->new($src);
  $self->_findSpriteBounds($gdImage);
}

sub _findSpriteBounds {
  my ($self, $gdImage) = @_;

  my ($width, $height) = $gdImage->getBounds();
  for my $x (0 .. $width) { # Try placing vertical slices looking for an uninterrupted line for automatic sprite detection

  }
  for my $y (0 .. $height) { # Place horizontal lines

  }
}

1;
__END__
=head1 NAME
Arkess::File::SpriteSheet::Inspector - Get properties from sprite sheet
The inspector can also automatically get sprite bounds from a spritesheet based
on alpha channels or a given color
