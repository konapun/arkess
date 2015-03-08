package AutumnDay::Character::Kid;

use strict;
use Arkess::Object;

sub create {
  my $kid = Arkess::Object->new(
    'AutumnDay::Character'
  );
  $kid->setName('Kid');

  # Give items
  
  return $kid;
}

1;
