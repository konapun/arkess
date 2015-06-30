package Test::AttrTest;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    retainedInitial => 'YES!'
  }
}

1;
