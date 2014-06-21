package Arkess::Component::EntityHolder;

use strict;
use base qw(Arkess::Component);

use Data::Dumper;

sub requires {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $entities) = @_;

  $entities = [] unless defined $entities;
  $self->{entities} = $entities;
}


sub exportAttributes {
  return {
    entities => shift->{entities}
  };
}

sub exportMethods {
  return {

    getEntities => sub {
      my $cob = shift;

      return $cob->get('entities');
    },

    clearEntities => sub {
      my $cob = shift;

      $cob->set('entities', []);
    },

    removeEntity => sub {
        my ($cob, $entitiy) = @_;

        # TODO
    },

    addEntity => sub { # FIXME
      my ($cob, $entity) = @_;

      my $entities = $cob->getEntities();
      push(@$entities, $entity);
      $cob->set('entities', $entities);
    }

  }
}

1;

__END__

=head1 NAME
Arkess::Component::EntityHolder - A component for an object which can hold other
entities
