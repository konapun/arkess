package AutumnDay::Item::Chest;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'AutumnDay::Fixture',
  ];
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setName('chest');
  $cob->setDescription(
    'A wooden chest made from weathered oak with brass fittings.',
    'A wooden chest.'
  );

  $cob->on('addEntity', sub {
    my $entity = shift;

    print "Adding entity $entity to chest\n";
  });
}

1;
