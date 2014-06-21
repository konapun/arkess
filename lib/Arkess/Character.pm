package Arkess::Character;

use strict;
use base qw(Arkess::Object);

sub new {
  my $package = shift;
  my $name = shift;

  my $base = $package->SUPER::new([
    'Arkess::Component::Named',
    'Arkess::Component::Mortal',
    'Arkess::Component::Mobile',
  ]);

  if (ref $name eq 'ARRAY') { # name is an array of additional components to extend character with
    $base = $base->extend($name);
    $name = shift; # See if there's a second argument to the constructor
  }

  $base->set('name', $name) if defined $name;
  return $base;
}

1;
