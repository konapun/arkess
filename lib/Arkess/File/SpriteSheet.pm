package Arkess::File::SpriteSheet;

use strict;
use Image::Size;
use SDLx::Sprite::Animated;

sub new {
  my $package = shift;
  my ($src, $width, $height, $padding) = @_;

  my $self = bless {
    width   => $width,
    height  => $height,
    padding => $padding,
    sprites => []
  }, $package;

$self->_test($src);
#  $self->_loadSprites($src);
  return $self;
}

use Data::Dumper;
sub _test {
  my ($self, $src) = @_;

  print "Exists!\n" if -e $src;
  my $animation = SDLx::Sprite::Animated->new->load($src);
  print Dumper($animation);
}

sub _loadSprites {
  my ($self, $source) = @_;

  die "Can't open spritesheet for loading form '$source'" unless -e $source;
  my ($imgX, $imgY) = imgsize($source);
  #my $rows = $img;
  my ($spriteX, $spriteY) = (0, 0); # coordinates for current sprite
  # TODO
}

1;
__END__
=head1 NAME Arkess::File::SpriteSheet - Load individual sprites from a sprite
sheet
