package Arkess::Tile;

use strict;
use base qw(Arkess::Object);

sub new {
  return shift->SUPER::new([
    'Arkess::Component::EntityHolder'
  ]);
}

1;
