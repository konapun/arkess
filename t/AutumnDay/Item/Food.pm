package AutumnDay::Item::Food;

use strict;
use base qw(Arkess::Component);

sub requires  {
  return [
    'AutumnDay::Item',
    'AutumnDay::Component::HeatSensitive'
  ];
}

sub initialize {
  my ($self, $calories) = @_;

  $self->{calories} = $calories;
}

sub exportAttributes {
  return {
    consumable => 1
  }
}

1;
