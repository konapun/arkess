package Arkess::Component::Colored;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $color) = @_;

  $color ||= [255, 0, 0];
  $self->{color} = $color;
}

sub exportAttributes {
  return {
    colored => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setColor => sub {
      my ($cob, $color) = @_;

      $self->{color} = $color;
    },

    getColor => sub {
      return $self->{color};
    }

  };
}

1;
