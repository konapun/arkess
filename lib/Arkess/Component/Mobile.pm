package Arkess::Component::Mobile;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $tile) = @_;

  $self->{tile} = $tile;
}

sub exportAttributes {
  return {
    tile => $self->{tile}
  };
}

sub exportMethods {
  return {
    setPosition => sub {
      #TODO
    },
    getPosition => sub {
      #TODO
    },
    move => sub {
      my ($cob, $direction) = @_;

      #TODO
    }
  }
}
1;
