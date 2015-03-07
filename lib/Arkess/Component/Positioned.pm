package Arkess::Component::Positioned;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $x, $y, $direction) = @_;

  $self->{x} = defined $x ? $x : 0;
  $self->{y} = defined $y ? $y : 0;
  $self->{direction} = defined $direction ? $direction : Arkess::Direction::DOWN;
}

sub exportMethods {
  my $self = shift;

  return {

    setCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $self->{x} = $x;
      $self->{y} = $y;
    },

    setX => sub {
      my ($cob, $x) = @_;

      $self->{x} = $x;
    },

    setY => sub {
      my ($cob, $y) = @_;

      $self->{y} = $y;
    },

    getCoordinates => sub {
      return ($self->{x}, $self->{y});
    },

    getX => sub {
      return $self->{x};
    },

    getY => sub {
      return $self->{y};
    },

    setDirection => sub {
      my ($cob, $direction) = @_;

      $self->{direction} = $direction;
    },

    getDirection => sub {
      return $self->{direction};
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Positioned - A component for entities who occupy space in the
game world. Note that this component does not provide screen coordinates; those
are contained in the Arkess::Component::Renderable package
