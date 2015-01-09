package Arkess::Component::AnimatedImage;

use strict;
use SDLx::Surface;
use Image::Size;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D',
    'Arkess::Component::Timed',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $interval, @images) = @_;

  die "Must provide animation interval" unless defined $interval;
  die "Must provide a list of images" unless @images && scalar(@images) > 0;

  my @sdlImages;
  foreach my $src (@images) {
    push(@sdlImages, SDLx::Surface->load($src));
  }
  my ($width, $height) = imgsize($images[0]);

  $self->{width} = $width;
  $self->{height} = $height;
  $self->{images} = [@sdlImages];
  $self->{interval} = $interval;
  $self->{frame} = 0;
  $self->{frames} = scalar(@images);
}

sub exportMethods {
  my $self = shift;

  return {

    setAnimationInterval => sub {
      my ($cob, $interval) = @_;

      $self->{interval} = $interval;
    },

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();
      
      $self->{frame} = 0 if $self->{frame} >= $self->{frames};
      $self->{images}->[$self->{frame}]->blit($renderer, undef, [$cob->getX(), $cob->getY()]);
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setDimensions($self->{width}, $self->{height}); # via Arkess::Component::2D
  $cob->on('setRuntime', sub {
    $cob->registerTimedEvent(sub {
      $self->{frame}++;
    }, $self->{interval});
  });
}

1;
