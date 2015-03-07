package Arkess::Component::Image;

# http://search.cpan.org/~kthakore/SDL_Perl-v2.2.6/lib/SDL/Tutorial/Images.pm

use strict;
use SDLx::Surface;
use Image::Size;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $src, $opts) = @_;

  if ($src eq 'INIT_SKIP') {
    $self->{width} = 0;
    $self->{height} = 0;
    return;
  }

  $self->{image} = undef;
  $self->{width} = 0;
  $self->{height} = 0;
  $self->_loadImage($src, $opts);
}

sub setPriority {
  return 0;
}

sub exportMethods {
  my $self = shift;

  return {

    setImageSource => sub {
      my ($cob, $src, $opts) = @_;

      $self->_loadImage($src, $opts);
      $cob->setDimensions($self->{width}, $self->{height});
    },

    getImageWidth => sub {
      return $self->{width};
    },

    getImageHeight => sub {
      return $self->{height};
    },

    getImageDimensions => sub {
      my $cob = shift;

      return ($cob->getImageWidth(), $cob->getImageHeight());
    },

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();

      $self->{image}->blit($renderer, undef, [$cob->getScreenCoordinates()]);
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setDimensions($self->{width}, $self->{height}); # via Arkess::Component::2D
}

sub _loadImage {
  my ($self, $src, $opts) = @_;

  $opts ||= {};
  die "Must provide image source for component Image" unless defined $src;
  die "Unable to read file '$src' for loading" unless -e $src;

  my ($width, $height) = imgsize($src);
  $self->{image} = SDLx::Surface->load($src);
  $self->{width} = $opts->{width} || $width;
  $self->{height} = $opts->{height} || $height;
}

1;
