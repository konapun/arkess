package AutumnDay::Component::Takeable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityPositioned'
  ]
}

sub exportAttributes {
  return {
    takeable => 1
  }
}

1;
