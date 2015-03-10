package AutumnDay::Item;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::Named' => "(unknown item)",
    'Arkess::Component::Describable' => "(no description)",
    'Arkess::Component::Actioned' => [],
    'Arkess::Component::Takeable' => [],
    'Arkess::Component::Usable' => sub { print "I don't know how to use that!" }
  };
}

sub setPriority {
  return 2;
}

sub exportMethods {
  return {

    getPosition => sub {
      my $cob = shift;

      if ($cob->isBeingHeld()) {
        return $cob->getHolder()->getPosition();
      }
    }

  };
}

1;
