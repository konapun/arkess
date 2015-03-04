package Plinko::Component::BounceSlide;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile'
  ];
}

1;
