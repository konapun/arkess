package Arkess::Component::Collidable;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Renderable' # needed to get screen coordinates to check for collisions
  ];
}

sub initialize {
  print "Collidable init!\n";
  my ($self, $runtime, $collisionTag) = @_;

  $self->{didCollide} = 0;
  $self->{runtime} = $runtime;
  $self->{collisionTag} = $collisionTag;
  $self->{collisionEvents} = {
    ALL => [] # default collision actions to run when no collideWith tag is given
  };
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
#print "($x2, $y2, $width2, $height2)\n";
            if ($x2 >= $x && $x2 <= $x + $width && $y2 >= $y && $y2 <= $y + $width) {
              print "Colliding $thisTag with $compareTag\n";
              foreach my $callback (@{$self->{collisionEvents}->{ALL}}) {
                die "COLLIDE callback!\n";
                $callback->($entity);
              }
              foreach my $callback (@{$self->{collisionEvents}->{$thisTag}}) {
                die "COLLIDE tag $thisTag\n";
              }
              foreach my $callback (@{$self->{collisionEvents}->{$compareTag}}) {
                die "COLLIDE TAG $compareTag\n";
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
print "COLLIDABLE exporting ($self)\n";
  return {

    # Callback triggered each time a collision happens
    collide => sub {
      my ($cob, $callback, $collisionTag) = @_;

      $collisionTag = 'ALL' unless defined $collisionTag;
      return $cob->collideWith($collisionTag, $callback);
    },

    collideWith => sub {
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
