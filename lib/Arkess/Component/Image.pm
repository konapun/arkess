package Arkess::Component::Image;

# http://search.cpan.org/~kthakore/SDL_Perl-v2.2.6/lib/SDL/Tutorial/Images.pm

use strict;
use SDLx::Surface;
use Image::Size;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $src, $opts) = @_;

  $opts ||= {};
  die "Must provide image source for component Image" unless defined $src;
  die "Unable to read file '$src' for loading" unless -e $src;
  $self->{image} = SDLx::Surface->load($src);

  my ($width, $height) = imgsize($src);
  $self->{width} = $opts->{width} || $width;
  $self->{height} = $opts->{height} || $height;
}

sub setPriority {
  return 0;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();

      $self->{image}->blit($renderer, undef, [$cob->getCoordinates()]);
    }
  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setDimensions($self->{width}, $self->{height}); # via Arkess::Component::2D
}

1;
