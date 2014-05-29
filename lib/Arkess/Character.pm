package Arkess::Character;

use strict;
use base qw(Arkess::Object);

sub new {
  return shift->SUPER::new([
    'Arkess::Component::Named',
    'Arkess::Component::Mortal',
    'Arkess::Component::Mobile',
  ]);
}

1;
