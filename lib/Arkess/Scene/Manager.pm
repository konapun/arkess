package Arkesss::Scene::Manager;

use strict;
use State::Machine;
use State::Machine::State;
use State::Machine::Transition;

sub new {
  my $package = shift;

  return bless {
    currentState => undef,
  }, $package;
}

1;

__END__
=head1 NAME
Arkess::Scene::Manager - A state machine based on https://theliquidfire.wordpress.com/2015/06/01/tactics-rpg-state-machine/
