package AutumnDay::Character::NPC;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Conversable'
  ];
}

1;
