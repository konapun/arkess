package ScrollMaker::Component::Breakable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::NullMethod'
  ];
}

sub exportAttributes {
  return
}

1;
