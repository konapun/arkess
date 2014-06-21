package Arkess::Component::Linked;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

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
      my ($cob, $direction, $tile) = @_;

      my $links = $cob->get('links');
      $links->{$direction} = $tile;
      $cob->set('links', $links);
    },

    getLink => sub {
      my ($cob, $direction) = @_;

      my $links = $cob->get('links');
      return $links->{$direction};
    },

    hasLink => sub {
      my ($cob, $direction) = @_;

      return defined $cob->get('links')->{$direction};
    }
    
  };
}

1;
