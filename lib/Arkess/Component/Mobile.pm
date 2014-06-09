package Arkess::Component::Mobile;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned'
  ]
}

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
      my ($self, $tile, $direction) = @_;
    },
    getPosition => sub {
      #TODO
    },
    move => sub {
      my ($cob, $direction) = @_;

      my $curpos = $cob->getPosition();

      #TODO
    }
  }
}
1;
