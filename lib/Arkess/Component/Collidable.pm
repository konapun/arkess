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
  my ($self, $collisionTag, $runtime) = @_;

  $self->{didCollide} = 0;
  $self->{colliding} = 0;
  $self->{runtime} = $runtime;
  $self->{collisionTag} = $collisionTag;
  $self->{collisionEvents} = {
    ALL => [], # default collision actions to run when no collideWith tag is given
    # all other events are added by collision tag
  };
  $self->{uncollisionEvents} = {
    ALL => [] # like above
  };
}

sub setPriority {
  return 2;
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $runtime = $self->{runtime};
  if (!$runtime) { # Automatically get runtime
    $cob->on('setRuntime', sub {
      my $runtime = shift;

      $self->_registerCollisionCheckWithRuntime($cob, $runtime);
    });
  }
  else {
    $self->_registerCollisionCheckWithRuntime($cob, $runtime);
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

    # Set a callback to be triggered each time a collision happens
    onCollide => sub {
      my ($cob, $callback, $collisionTag) = @_;

      $collisionTag = 'ALL' unless defined $collisionTag;
      return $cob->onCollideWith($collisionTag, $callback);
    },

    onUncollide => sub {
      my ($cob, $callback, $collisionTag) = @_;

      $collisionTag = 'ALL' unless defined $collisionTag;
      return $cob->onUncollideWith($collisionTag, $callback);
    },

    onCollideWith => sub {
      my ($cob, $collisionTag, $callback) = @_;

      $self->{collisionEvents}->{$collisionTag} = [] unless ref $self->{collisionEvents}->{$collisionTag} eq 'ARRAY';
      push(@{$self->{collisionEvents}->{$collisionTag}}, $callback);
    },

    onUncollideWith => sub {
      my  ($cob, $collisionTag, $callback) = @_;

      $self->{uncollisionEvents}->{$collisionTag} = [] unless ref $self->{uncollisionEvents}->{$collisionTag} eq 'ARRAY';
      push(@{$self->{uncollisionEvents}->{$collisionTag}}, $callback);
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

sub _registerCollisionCheckWithRuntime {
  my ($self, $cob, $runtime) = @_;

  $runtime->getEventBus()->bind(Arkess::Event::BEFORE_RENDER, sub {
    my ($x, $y) = $cob->getCoordinates();
    my $thisTag = $cob->getCollisionTag();
    my ($width, $height) = $cob->getDimensions();

    foreach my $entity ($runtime->getEntities()) {
      next if $entity == $cob; # Don't check for collisions against self
      if ($entity->hasAttribute('collidable')) {
        my $compareTag = $entity->getCollisionTag();
        my ($x2, $y2) = $entity->getCoordinates();
        my ($width2, $height2) = $entity->getDimensions();
        if (($y2 + $height2 >= $y && $y2 <= $y + $height)  && ($x2 + $width2 >= $x && $x2 <= $x + $width)) {
          $self->{colliding} = 1;
          $entity->{colliding} = 1;

          foreach my $callback (@{$self->{collisionEvents}->{ALL}}) {
            $callback->($entity);
          }
          foreach my $callback (@{$entity->{collisionEvents}->{ALL}}) {
            $callback->($self);
          }
          foreach my $callback (@{$entity->{collisionEvents}->{$thisTag}}) {
            $callback->($self);
          }
          foreach my $callback (@{$self->{collisionEvents}->{$compareTag}}) {
            $callback->($entity);
          }
        }
        else { # no collision between $self and $entity
          if ($entity->{colliding}) { # was colliding but is no longer; trigger uncollide
            foreach my $callback (@{$entity->{uncollisionEvents}->{ALL}}) {
              $callback->($self);
            }
            foreach my $callback (@{$self->{uncollisionEvents}->{ALL}}) {
              $callback->($entity);
            }
            foreach my $callback (@{$entity->{uncollisionEvents}->{$thisTag}}) {
              $callback->($self);
            }
            foreach my $callback (@{$self->{uncollisionEvents}->{$compareTag}}) {
              $callback->($entity);
            }
          }
          $entity->{colliding} = 0;
        }
      }
    }
  });
}

1;
