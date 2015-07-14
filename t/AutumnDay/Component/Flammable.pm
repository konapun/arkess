package AutumnDay::Component::Flammable;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    flammable => 1
  }
}

sub exportMethods {
  return {
    burn => sub {
      my $cob = shift;

      if ($cob->is('positioned')) { # spread the fire

      }
      $cob->destroy();
    }
  }
}
1;
