package AutumnDay::Tile;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Describable',
    'Arkess::Component::EntityHolder',
    'Arkess::Component::Linked'
  ];
}

sub initialize {
  my $self = shift;

  $self->{layout} = {
    above => [],
    below => [],
    # TODO
  };
}
sub exportMethods {
  return {
    setLayout => sub {
      print "TODO\n";
    }
  }
}
1;
