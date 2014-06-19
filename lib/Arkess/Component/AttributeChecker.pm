package Arkess::Component::AttributeChecker;

use strict;
use base qw(Arkess::Component);

sub exportMethods {
  return {
    hasAttribute => sub {
      my ($cob, $key) = @_;
      
      return $cob->attributes->has($key);
    }
  }
}

1;
