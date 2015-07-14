package AutumnDay::Tile::PumpkinPatch;

use strict;
use base qw(Arkess::Object);

sub new {
  my $self = shift->SUPER::new();

  $self->_configure();
}

sub _configure {
  my $self = shift;

  my $pumpkin = Arkess::Object->new( 'AutumnDay::Item::Pumpkin' );
  for (1 .. 10) {
    $self->addEntity($pumpkin->clone());
  }
}

1;
