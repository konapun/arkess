package Arkess::Tile;

use strict;
use base qw(Arkess::Object);

sub new {
  my $package = shift;
  my $additional = shift;

  my $base = $package->SUPER::new([
    'Arkess::Component::EntityHolder',
    'Arkess::Component::Linked'
  ]);
  return $base->extend($additional);
}

1;

__END__
=head1 NAME
Arkess::Tile - The object which defines the basis for movement in all Arkess
games
