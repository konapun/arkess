package Arkess::Component::Projectile;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Damaging',
    'Arkess::Component::Collidable'
  ];
}

1;
