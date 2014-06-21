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

      return @{$cob->get('entities')};
    },

    removeEntities => sub {
      my $cob = shift;

      $cob->set('entities', []);
    },

    addEntity => sub { # FIXME
      my ($cob, $entity) = @_;

      my @entities = $cob->getEntities();
      print "BEFORE: " . scalar(@entities) . "\n";
      print "Pushing " . Dumper($entity) . "\n";
      push(@entities, $entity);
      $cob->set('entities', [@entities]);

      use Data::Dumper;
      print "ENTITIES: " . Dumper($cob->get('entities'));
    }

  }
}
1;

__END__

=head1 NAME
Arkess::Component::EntityHolder - A component for an object which can hold other
entities
