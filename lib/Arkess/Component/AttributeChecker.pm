package Arkess::Component::AttributeChecker;

use strict;
use base qw(Arkess::Component);

sub exportMethods {
  return {
    hasAttribute => sub {
      my ($cob, $key) = @_;

      $cob->attributes->each(sub {
        my $key = shift;

        print "FIXME - KEY: $key\n";
      });
      return $cob->attributes->has($key);
    }
  }
}

1;
