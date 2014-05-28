package Arkess::Tile;

use strict;
use base qw(Arkess::Core::Object);
use Arkess::Component::Observable;

sub new {
  return shift->SUPER::new({
    requires => ['observable'],
    actions => {
      prebuilt: [],
      definitions: {}
    }
  });
}

1;
