package Arkess::Component::MethodChecker;

use strict;
use base qw(Arkess::Component);

sub exportMethods {
  return {
    hasMethod => sub {
      my ($cob, $key) = @_;

      return $cob->methods->has($key);
    }
  }
}

1;
