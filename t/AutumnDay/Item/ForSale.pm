package AutumnDay::Item::ForSale;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'AutumnDay::Item'
  ];
}

sub initialize {
  my ($self, $cost) = @_;

  $self->{cost} = $cost;
}

sub exportMethods {
  my $self = shift;

  return {

    sell => sub {

    },

    getPrice => sub {

    },

    setPrice => sub {
      
    }
  }
}
1;
