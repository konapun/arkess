package Arkess::Component::Attacking;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Eqippable'
  ];
}

sub exportMethods {
  return {
    attack => sub {
      my ($cob, $target) = @_;

      my $weapon = $cob->getEquippedAttack(); # weapon decides attack power/calculations
      if ($target->hasAttribute('hp')) { # don't try to take damage from something that doesn't support it
        $target->takeDamage($weapon->calculateDamageForTarget($target));
        # TODO
      }
    }
  };
}
1;
