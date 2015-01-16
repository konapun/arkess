package Arkess::File::SpriteSheet::Inspector;

use strict;
use GD;
use GD::Image;
use Color::Rgb;
use Arkess::File::SpriteSheet::Inspector::Result;

sub new {
  my $package = shift;
  my ($tolerance, $color) = @_; # +- range to treat as equal and color to use as alpha

  $tolerance = defined $tolerance ? $tolerance : 20;
  $color = defined $color ? $color : 'white';
  my $colorObj = Color::Rgb->new(
    rgb_txt => '/usr/share/X11/rgb.txt' # FIXME
  );
  return bless {
    colorObj  => $colorObj,
    color     => [$colorObj->rgb($color)],
    tolerance => $tolerance
  }, $package;
}

sub setTolerance {
  my ($self, $tolerance) = @_;

  $self->{tolerance} = $tolerance;
}

sub inspect {
  my ($self, $src, $color) = @_;

# FIXME: Just return this for sprite testing
  my @results;
  foreach my $x (10, 80, 150, 220, 290, 360, 430) {
    foreach my $y (10, 120) {
      push(@results, Arkess::File::SpriteSheet::Inspector::Result->new($x, $y, 40, 90))
    }
  }
  return @results;

  $color = defined $color ? [$self->{colorObj}->hex2rgb($color)] : $self->{color};
  my $gdImage = GD::Image->new($src);
  $gdImage->trueColor(1);
  $self->_findSpriteBounds($gdImage, $color);
}

sub _findSpriteBounds {
  my ($self, $gdImage, $testColor) = @_;

  my ($width, $height) = $gdImage->getBounds();
  my (@rows, @columns);
  COLUMN: for my $x (0 .. $width-1) { # Try placing vertical slices looking for an uninterrupted line for automatic sprite detection
    for my $y (0 .. $height-1) {
      my ($r, $g, $b) = $gdImage->rgb($gdImage->getPixel($x, $y));
      next COLUMN unless $self->_colorsAreEqual([$r, $g, $b], $testColor);
    }
    print "FOUND COLUMN AT $x\n";
    push(@columns, $x);
  }
  for my $y (0 .. $height-1) { # Place horizontal lines
    COLUMN: for my $x (0 .. $width-1) {
      my ($r, $g, $b) = $gdImage->rgb($gdImage->getPixel($x, $y));
      next COLUMN unless $self->_colorsAreEqual([$r, $g, $b], $testColor);
    }

    push(@rows, $y);
  }

print "Got " . scalar(@columns) . " columns\n";
print "Got " . scalar(@rows) . " rows\n";
  # Build sprite bounds
  my @coordinates;
  foreach my $row (@rows) {
    foreach my $column (@columns) {
      push(@coordinates, [$column, $row]);
    }
  }
  print "Spritesheet contained " . scalar(@coordinates) . " sprites<br>\n";
  return @coordinates;
}

sub _colorsAreEqual {
  my ($self, $color1, $color2) = @_;

  my $tolerance = $self->{tolerance};
  my ($r1, $g1, $b1) = @$color1;
  my ($r2, $g2, $b2) = @$color2;
  return (($r1 >= $r2-$tolerance && $r1 <= $r2+$tolerance) && ($g1 >= $g2-$tolerance && $g1 <= $g2+$tolerance) && ($b1 >= $b2-$tolerance && $b1 <= $b2+$tolerance));
}

1;
__END__
=head1 NAME
Arkess::File::SpriteSheet::Inspector - Get properties from sprite sheet
The inspector can also automatically get sprite bounds from a spritesheet based
on alpha channels or a given color
