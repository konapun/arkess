package Arkess::Component::Image;

# http://search.cpan.org/~kthakore/SDL_Perl-v2.2.6/lib/SDL/Tutorial/Images.pm

use strict;
use SDL::Image;
use SDL::Rect;
use SDL::Video;
use Image::Size;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $src, $opts) = @_;

  $opts ||= {};
  die "Must provide image source for component Image" unless defined $src;
  $self->{image} = SDL::Image::load($src);
  my ($width, $height) = imgsize($src);
  $self->{width} = $opts->{width} || $width;
  $self->{height} = $opts->{height} || $height;

  $self->{rect} = undef;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();

      die "Renderer not set" unless defined $renderer;
      my ($x, $y) = $cob->getScreenCoordinates();
      my ($width, $height) = $cob->getDimensions();
      my $image = $self->{image};
      my $rect = $self->{rect};

#      SDL::Video::blit_surface($image, $self->{rect}, $renderer, $rect);
#      SDL::Video::update_rects($renderer, $rect);
      $self->{rect} = $rect;
    }
  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  my ($x, $y) = $cob->getScreenCoordinates();
  my ($width, $height) = $cob->getDimensions();
  $self->{rect} = SDL::Rect->new($x, $y, $width, $height);
}

1;
