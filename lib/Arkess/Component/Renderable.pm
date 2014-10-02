package Arkess::Component::Renderable;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    renderable => 1
  };
}

sub exportMethods {
  return {
    render => sub {
      # pass - not implemented here
    }
  }
}
1;
