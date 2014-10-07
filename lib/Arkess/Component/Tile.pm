package Arkess::Component::Tile;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityHolder',
    'Arkess::Component::Sprite'
    'Arkess::Component::Linked',
  ];
}

1;

__END__
=head1 NAME
Arkess::Component::Tile - base component for a tile
