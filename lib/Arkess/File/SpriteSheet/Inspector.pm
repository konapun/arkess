package Arkess::File::SpriteSheet::Inspector;

use strict;
use GD;
use GD::Image;
use Color::Rgb;

sub new {
  my $package = shift;
  my $color = shift; # color to treat as alpha

  $color = defined $color ? $color : 'white';
  my $colorObj = Color::Rgb->new(
    rgb_txt => '/usr/share/X11/rgb.txt' # FIXME
  );
  print $colorObj->rgb($color) . "\n";
  return bless {
    colorObj => $colorObj,
    color => [$colorObj->rgb($color)]
  }, $package;
}

sub inspect {
  my ($self, $src, $color) = @_;

  $color = defined $color ? $self->colorObj->rgb($color) : $self->{color};
  my $gdImage = GD::Image->new($src);
  $self->_findSpriteBounds($gdImage, $color);
}

sub _findSpriteBounds {
  my ($self, $gdImage, $color) = @_;

print "COL: " . $self->{color} . "\n";
  my ($cr, $cg, $cb) = @{$self->{color}};
  my ($width, $height) = $gdImage->getBounds();
  for my $x (0 .. $width) { # Try placing vertical slices looking for an uninterrupted line for automatic sprite detection
    ROW: for my $y (0 .. $height) {
      my ($r, $g, $b) = $gdImage->rgb($gdImage->getPixel($x, $y));
      next ROW if ($r != $cr || $g != $cg || $b != $cb);
    }
    #TODO
    print "Found a row at $x!\n";
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
