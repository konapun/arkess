package Arkess::Item::Weapon;

use strict;
use base qw(Arkess::Item);

sub new {
  my $package = shift;

  return $package->SUPER::new([
    'Arkess::Component::Damaging'
  ]);
}

1;

__END__
=head1 NAME
Arkess::Item::Weapon - Base class for weapon creation
