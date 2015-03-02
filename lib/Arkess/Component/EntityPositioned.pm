package Arkess::Component::EntityPositioned;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $entity) = @_;

  $self->{position} = $entity;
  if ($entity) {
    die "FIXME";
    $self->_setPosition($entity);
  }
}

sub exportMethods {
  my $self = shift;

  return {

    setPosition => sub {
      my ($cob, $entity) = @_;

      $self->_setPosition($cob, $entity);
    },

    getPosition => sub {
      return $self->{position};
    },

    move => sub {
      my ($cob, $direction) = @_;

      my $return = 0;
      my $tile = $self->{position};
      if ($tile->hasLink($direction)) {
        $tile->removeEntity($cob);
        $self->_setPosition($cob, $tile->getLink($direction));
        $return = 1; # move succeeded
      }
      $cob->trigger('move', $direction);
      return $return; # Couldn't move
    }

  };
}

sub _setPosition {
  my ($self, $cob, $entity) = @_;

  $self->{position} = $entity;
  if ($entity->hasAttribute('holdsEntities')) {
    $entity->addEntity($cob); # FIXME - remove entity also
  }
}

1;
