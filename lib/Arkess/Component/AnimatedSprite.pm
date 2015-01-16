package Arkess::Component::AnimatedSprite;

use strict;
use SDLx::Sprite;
use Arkess::File::SpriteSheet::Inspector;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Timed',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $src, $interval, $spritesheetBackgroundColor) = @_;

  $self->{sprites} = $self->_loadSpriteSheet($src, $spritesheetBackgroundColor); # Individual sprites, loaded from sprite sheet and referred to by their 2D coords
  $self->{activeSequence} = undef;

  $self->{interval} = $interval;
  $self->{frame} = 0; # specific frame within animation
  $self->{sprite} = undef; # specific sprite to be rendered in the current frame
die "DIED ON PURPOSE";
}

sub exportMethods {
  my $self = shift;

  return {

    addAnimationSequence => sub {
      my ($cob, $name, $frames) = @_;

      # TODO: Check frames bounds
      $self->{animations}->{$name} = $frames;
    },

    getCurrentSequence => sub {
      return $self->{activeSequence};
    },

    setSequence => sub {
      my ($cob, $name, $frame) = @_;

      $frame = 0 unless defined $frame;
      die "There is no sequence named '$name'. Perhaps you forgot to create it with addAnimationSequence?" unless defined $self->{animations}->{$name};
      $self->{frame} = $frame;
      $self->{activeSequence} = $name;
    },

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();

      $self->{frame}->blit($renderer, undef, [$cob->getX(), $cob->getY()]);
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setDimensions($self->{width}, $self->{height}); # via Arkess::Component::2D
  $cob->on('setRuntime', sub {
    $cob->registerTimedEvent(sub {

    }, $self->{interval});
  });
}

# Load a sprite sheet using SDLx::Sprite::Animated since it's probably a
# dependency anyway
sub _loadSpriteSheet {
  my ($self, $src, $backgroundColor) = @_;

  my @sprites;
  my $spriteInspector = Arkess::File::SpriteSheet::Inspector->new();
  my @spriteCoords = $spriteInspector->inspect($src, $backgroundColor);
  foreach my $sprite (@spriteCoords) {
    print "PUSHING\n";
    push(@sprites, SDLx::Sprite->new(
      image => $src,
      clip => SDL::Rect->new($sprite->getX(), $sprite->getY(), $sprite->getWidth(), $sprite->getHeight()),
#      alpha_key => $backgroundColor
    ));
    print "PUSHED\n";
  }

}

1;
__END__
=head1 NAME
Arkess::Component::AnimatedSprite - Component for creating and animating a sprite
