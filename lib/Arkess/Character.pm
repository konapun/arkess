package Arkess::Character;

use strict;
use base qw(Arkess::Object);

sub new {
  my $package = shift;
  my $name = shift;

  my $self = $package->SUPER::new([
    'Arkess::Component::Named',
    'Arkess::Component::Mortal',
    'Arkess::Component::Mobile',
  ]);
  $self->set('name', $name);
  return $self;
}

1;
