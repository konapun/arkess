package Arkess::Component::AnimatedSprite;

use strict;
use SDLx::Surface;
use SDL::GFX; # http://sdl.perl.org/SDL-GFX-Rotozoom.html
use Image::Size;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D',
    'Arkess::Component::Renderable',
    'Arkess::Component::Timed',
    'Arkess::Component::Observable',
    'Arkess::Component::RuntimeAware'
  ];
}

sub setPriority {
  return 2;
}

sub initialize {
  my ($self, $src, $dimensions, $interval) = @_;

  die "Requires sprite source, dimensions, and interval" unless defined $interval;
  $self->{sprite} = SDLx::Surface->load($src) or die $!;
  $self->{activeSequence} = undef;
  $self->{interval} = $interval;
  $self->{frame} = 0; # specific frame within animation
  $self->{animations} = {};

  $self->_getSpriteDimensions($src, $dimensions);
}

sub exportMethods {
  my $self = shift;

  return {

    addAnimationSequence => sub {
      my ($cob, $name, $frames) = @_;

      # TODO: Check frames bounds
      $self->{animations}->{$name} = $frames;
      $self->{activeSequence} = $name unless defined $self->{activeSequence};
    },

    addAnimationSequences => sub {
      my ($cob, $sequences) = @_;

      foreach my $name (keys %$sequences) {
        $cob->addAnimationSequence($name, $sequences->{$name});
      }
    },

    getCurrentSequence => sub {
      return $self->{activeSequence};
    },

    getCurrentAnimationFrame => sub {
      return $self->{frame};
    },

    setSequence => sub {
      my ($cob, $name, $frame) = @_;

      $frame = 0 unless defined $frame;
      die "There is no sequence named '$name'. Perhaps you forgot to create it with addAnimationSequence?" unless defined $self->{animations}->{$name};
      $self->{frame} = $frame;
      $self->{activeSequence} = $name;
    },

    rotate => sub {

    },

    zoom => sub {

    },

    setAlpha => sub {

    },

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();
      use Data::Dumper;

      my $width = $self->{width};
      my $height = $self->{height};
      my ($y, $x) = @{$self->{animations}->{$self->{activeSequence}}->[$self->{frame}]};
      $self->{sprite}->blit($renderer, SDL::Rect->new($x*$width, $y*$height, $width, $height), [$cob->getX(), $cob->getY()]);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setDimensions($self->{width}, $self->{height});
  $cob->whenRuntimeAvailable(sub {
    $cob->registerTimedEvent(sub {
      return unless $self->{activeSequence};
      $self->{frame}++;
      $self->{frame} = 0 if $self->{frame} >= scalar(@{$self->{animations}->{$self->{activeSequence}}});
    }, $self->{interval});
  });
}

sub _getSpriteDimensions {
  my ($self, $image, $bounds) = @_;

  my ($fullWidth, $fullHeight) = imgsize($image);
  my ($nx, $ny) = @$bounds;
  my $spriteWidth = $fullWidth / $nx;
  my $spriteHeight = $fullHeight / $ny;

  $self->{width} = $spriteWidth;
  $self->{height} = $spriteHeight;
}

1;
__END__
=head1 NAME
Arkess::Component::AnimatedSprite - Component for creating sprite animation
sequences from a spritesheet
