package Arkess::Component::Grid::Movement;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile'
  ];
}

sub initialize {
  my $self = shift;


}

sub exportMethods {
  my $self = shift;

  return {
    'move' => sub {
      
    }
  };
}

1;
