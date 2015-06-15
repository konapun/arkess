package Arkess::Scene;

use strict;

sub enter {
  shift->addListeners();
}

sub exit {
  shift->removeListeners();
}

sub onDestroy {
  shift->removeListeners();
}

sub addListeners {}

sub removeListeners {}

1;
__END__
=head1 NAME
Arkess::Scene - A state machine for managing scenes
