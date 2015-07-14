package AutumnDay::Compnent::Edible;

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

sub exportMethods {
  my $self = shift;

  return {
    getCalories => sub {
      return $self->{calories};
    },

    eat => sub {
      my $cob = shift;

      print "TODO: EATING\n";
    }
  }
}
1;
