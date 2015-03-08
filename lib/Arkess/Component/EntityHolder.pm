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

    listEntities => sub {
      return @{$self->{entities}};
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
          return splice(@{$self->{entities}}, $index, 1);
        }
        $index++;
      }
    },

    addEntity => sub {
      my ($cob, $entity) = @_;

      push(@{$self->{entities}}, $entity);
      $cob->trigger('addEntity', $entity); # FIXME should happen automatically
    }

  }
}

1;

__END__

=head1 NAME
Arkess::Component::EntityHolder - A component for an object which can hold other
entities
