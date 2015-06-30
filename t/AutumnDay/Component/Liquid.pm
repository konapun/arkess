package AutumnDay::Component::Liquid;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    liquid => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    boil => sub {

    },

    freeze => sub {
      
    }
  }
}

1;
