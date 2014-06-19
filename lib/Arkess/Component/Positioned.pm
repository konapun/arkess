package Arkess::Component::Positioned;

use strict;
use base qw(Arkess::Component);
use Arkess::Direction;

sub initialize {
  my ($self, $tile, $direction) = @_;

  $tile = undef unless defined $tile;
  $direction = DOWN unless defined $direction;

  $self->{tile} = $tile;
  $self->{direction} = $direction;
}

sub exportAttributes {
  my $self = shift;

  return {
    position => {
      tile => $self->{tile},
      direction => $self->{direction}
    }
  };
}

sub exportMethods {
  return {
    getPosition => sub {
      my $cob = shift;

      my $position = $cob->get('position');
      return [
        $position->{tile},
        $position->{direction}
      ];
    },
    getDirection => sub {
      return shift->get('position')->{direction};
    },
    getTile => sub {
      return shift->get('position')->{tile};
    }
  }
}

1;
