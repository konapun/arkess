package Fighting::Fighter;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $args) = @_;

  $self->__bulkInitialize($args, [
    'Arkess::Component:Something'
  ]);
}
1;
