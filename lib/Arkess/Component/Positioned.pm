package Arkess::Component::Positioned;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $x, $y) = @_;

  $self->{x} = defined $x ? $x : 0;
  $self->{y} = defined $y ? $y : 0;
}

sub exportMethods {
  my $self = shift;

  return {

    setCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $self->{x} = $x;
      $self->{y} = $y;
    },

    getCoordinates => sub {
      return ($self->{x}, $self->{y});
    }
  }
}

1;
