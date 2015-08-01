package AutumnDay::Item::CaramelApple;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'AutumnDay::Component::Food'
  ];
}

sub finalize {
  my ($self, $cob) = @_;

}

1;
