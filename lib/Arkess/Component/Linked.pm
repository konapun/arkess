package Arkess::Component::Linked;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
    'Arkess::Component::Getter'
  ];
}

sub exportAttributes {
  return {
    links => {
      up    => undef,
      down  => undef,
      left  => undef,
      right => undef
    }
  };
}

sub exportMethods {
  return {

    setLink => sub {
      my ($cob, $direction, $tile, $bidirectional) = @_;

      $bidirectional = 1 unless defined $bidirectional; # connect tiles forward and backwards by default
      my $links = $cob->get('links');
      $links->{$direction} = $tile; # link cob to tile
      $cob->set('links', $links);
      $tile->setLink(Arkess::Direction::reverse($direction), $cob, 0) if $bidirectional; # link tile to cob in reverse direction - bidirectional false to avoid infinite recursion
    },

    getLink => sub {
      my ($cob, $direction) = @_;

      my $links = $cob->get('links');
      return $links->{$direction};
    },

    hasLink => sub {
      my ($cob, $direction) = @_;

      my $ret = defined($cob->get('links')->{$direction});
      return $ret ? 1 : 0;
    }

  };
}

1;
