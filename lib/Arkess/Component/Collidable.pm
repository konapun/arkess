package Arkess::Component::Collidable;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D',
    'Arkess::Component::Renderable' # needed to get screen coordinates to check for collisions (or maybe use non-screen coords instead?)
  ];
}

sub initialize {
  my ($self, $runtime, $collisionTag) = @_;

  $self->{didCollide} = 0;
  $self->{colliding} = 0;
  $self->{runtime} = $runtime;
  $self->{collisionTag} = $collisionTag;
  $self->{collisionEvents} = {
    ALL => [] # default collision actions to run when no collideWith tag is given
  };
  $self->{uncollisionEvents} = {
    ALL => [] # like above
  };
}

sub setPriority {
  return 2; # needs a higher priority because observable needs to be loaded first
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $runtime = $self->{runtime};
  if (!$runtime) {
    $cob->on('setRuntime', sub {
      my $runtime = shift;

      $runtime->getEventBus()->bind(Arkess::Event::BEFORE_RENDER, sub {
        my ($x, $y) = $cob->getCoordinates();
        my $thisTag = $cob->getCollisionTag();
        my ($width, $height) = $cob->getDimensions();

        foreach my $entity ($runtime->getEntities()) {
          next if $entity == $cob;
          if ($entity->hasAttribute('collidable')) {
            my $compareTag = $entity->getCollisionTag();
            my ($x2, $y2) = $entity->getCoordinates();
            my ($width2, $height2) = $entity->getDimensions();
            if ($x2 >= $x && $x2 <= $x + $width && $y2 >= $y && $y2 <= $y + $width) {
              $self->{colliding} = 1; # FIXME: Do for all collisions, not just this

              foreach my $callback (@{$self->{collisionEvents}->{ALL}}) {
                $callback->($entity);
              }
              foreach my $callback (@{$self->{collisionEvents}->{$thisTag}}) {
                $callback->($entity);
              }
              foreach my $callback (@{$self->{collisionEvents}->{$compareTag}}) {
                $callback->($entity);
              }
            }
          }
        }
      });
    });
  }
}

sub exportAttributes {
  return {
    collidable => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    # Callback triggered each time a collision happens
    collide => sub {
      my ($cob, $callback, $collisionTag) = @_;

      $collisionTag = 'ALL' unless defined $collisionTag;
      return $cob->collideWith($collisionTag, $callback);
    },

    onCollide => sub {
      my ($cob, $callback, $collisionTag) = @_;

      $collisionTag = 'ALL' unless defined $collisionTag;
      return $cob->collideWith($collisionTag, $callback);
    },

    uncollide => sub {

    },

    collideWith => sub {
      my ($cob, $collisionTag, $callback) = @_;

      $self->{collisionEvents}->{$collisionTag} = [] unless ref $self->{collisionEvents}->{$collisionTag} eq 'ARRAY';
      push(@{$self->{collisionEvents}->{$collisionTag}}, $callback);
    },

    uncollideWith => sub {
      my ($cob, $collisionTag, $callback) = @_;

    },

    onCollideWith => sub {
      my ($cob, $collisionTag, $callback) = @_;

      $self->{collisionEvents}->{$collisionTag} = [] unless ref $self->{collisionEvents}->{$collisionTag} eq 'ARRAY';
      push(@{$self->{collisionEvents}->{$collisionTag}}, $callback);
    },

    # Tag for collideWith
    setCollisionTag => sub {
      my ($cob, $tag) = @_;

      die "Collision tag 'ALL' is reserved" if $tag eq 'ALL';
      $self->{collisionTag} = $tag;
      $self->{collisionEvents}->{$tag} = [] unless ref $self->{collisionEvents}->{$tag} eq 'ARRAY';
    },

    getCollisionTag => sub {
      return $self->{collisionTag};
    }

  };
}

1;
