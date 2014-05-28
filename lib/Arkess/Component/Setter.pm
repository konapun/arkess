package Arkess::Component::Setter;

use strict;
use base qw(Cobsy::Component);

sub exportMethods {
  return {
    set => sub {
      my ($cob, $key, $value) = @_;

      return $cob->attributes->set($key, $value);
    }
  }
}

1;
