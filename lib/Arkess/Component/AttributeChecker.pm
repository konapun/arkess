package Arkess::Component::AttributeChecker;

use strict;
use base qw(Arkess::Component);

sub exportMethods {
  return {

    # Alias for hasAttribute
    is => sub {
      my ($cob, $key) = @_;

      return $cob->hasAttribute($key);
    },

    hasAttribute => sub {
      my ($cob, $key) = @_;

      return $cob->attributes->has($key);
    }
  }
}

1;
