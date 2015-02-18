package Arkess::Component::Linked;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{links} = {
    up    => undef,
    down  => undef,
    left  => undef,
    right => undef
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setLink => sub {
      my ($cob, $direction, $tile, $bidirectional) = @_;

      $bidirectional = 1 unless defined $bidirectional; # connect tiles forward and backwards by default
      $self->{links}->{$direction} = $tile; # link cob to tile
      $tile->setLink(Arkess::Direction::reverse($direction), $cob, 0) if $bidirectional; # link tile to cob in reverse direction - bidirectional false to avoid infinite recursion
    },

    getLink => sub {
      my ($cob, $direction) = @_;

      return $self->{links}->{$direction};
    },

    hasLink => sub {
      my ($cob, $direction) = @_;

      return defined($self->{links}->{$direction});
    }

  };
}

1;
