package AutumnDay::Fixture;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::Named' => "(unknown item)",
    'Arkess::Component::Describable' => "(no description)",
    'Arkess::Component::Actioned' => [],
  };
}

1;
