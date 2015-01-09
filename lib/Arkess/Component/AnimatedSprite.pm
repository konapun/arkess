package Arkess::Component::AnimatedSprite;

use strict;
use SDLx::Sprite::Animated;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Timed',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $src, $interval) = @_;

  die "Can't load sprite file '$src'" unless -e $src;
  my $animation = SDLx::Sprite::Animated->new()->load($src);

  $self->{animation} = $animation;
  $self->{interval} = $interval;
  $self->{frame} = $animation->next();
}

sub exportMethods {
  my $self = shift;

  return {

    spriteSequence => sub {

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
      $self->{frame} =  $self->{animation}->next();
    }, $self->{interval});
  });
}

1;
__END__
=head1 NAME
Arkess::Component::AnimatedSprite - Component for creating and animating a sprite
