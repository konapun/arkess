package Arkess::Component::EntityHolder;

use strict;
use base qw(Arkess::Component);

use Data::Dumper;

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $entities) = @_;

  $entities = [] unless defined $entities;
  $self->{entities} = $entities;
}


sub exportAttributes {
  return {
    holdsEntities => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    # Find an entity by its object reference
    findEntity => sub {
      my ($cob, $entity) = @_;

      if (ref $entity eq 'CODE') {
        return $cob->findEntityCallback($entity);
      }
      foreach my $holding ($cob->listEntities()) {
        return $holding if $entity eq $holding;
      }
    },

    # Locate an entity by passing in a callback to be called against every
    # contained entity. Returns the entity passed to the callback if $callback
    # returns a truthy value
    findEntityCallback => sub {
      my ($cob, $callback) = @_;

      foreach my $holding ($cob->listEntities()) {
        return $holding if $callback->($holding);
      }
    },

    listEntities => sub {
      return @{$self->{entities}};
    },

    listEntitiesExcept => sub {
      my ($cob, $except) = @_;

      my @filtered;
      foreach my $entity ($cob->listEntities()) {
        push(@filtered, $entity) unless $entity eq $except;
      }
      return @filtered;
    },

    listEntitiesWithAttribute => sub {
      my ($cob, $attribute) = @_;

      my @filtered;
      foreach my $entity ($cob->listEntities()) {
        push(@filtered, $entity) if $entity->hasAttribute($attribute);
      }
      return @filtered;
    },

    getEntities => sub {
      return $self->{entities};
    },

    clearEntities => sub {
      $self->{entities} = [];
    },

    removeEntity => sub {
      my ($cob, $entity) = @_;

      my $index = 0;
      foreach my $contained (@{$self->{entities}}) {
        if ($contained eq $entity) {
          my $found = splice(@{$self->{entities}}, $index, 1);
          $found->setPosition(undef) if $entity->is('entityPositioned');
        }
        $index++;
      }
    },

    addEntity => sub {
      my ($cob, $entity) = @_;

      $entity->setPosition($cob) if $entity->is('entityPositioned');
      push(@{$self->{entities}}, $entity);
    }

  }
}

1;

__END__

=head1 NAME
Arkess::Component::EntityHolder - A component for an object which can hold other
entities
