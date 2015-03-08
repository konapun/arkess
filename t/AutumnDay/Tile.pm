package AutumnDay::Tile;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Describable',
    'Arkess::Component::EntityHolder',
    'Arkess::Component::Linked'
  ];
}

1;
