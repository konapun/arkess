package AutumnDay::Character::Component::HungerMove;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mortal',
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $movesPerUnit) = @_; # The number of moves before HP drops by 1

  $self->{movesPerUnit} = $movesPerUnit || 2;
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $currentMoves = 0;
  $cob->on('move', sub {
    print "MOVING\n";
    if ($currentMoves++ == $self->{movesPerUnit}) {
      $cob->takeDamage(1);
      $currentMoves = 0;
    }
  })
}

1;
