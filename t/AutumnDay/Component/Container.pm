package AutumnDay::Component::Container;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityHolder'
  ];
}

1;
