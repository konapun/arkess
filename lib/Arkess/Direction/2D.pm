package Arkess::Direction::2D;

use strict;
use base qw(Exporter);

use constant NORTH => 'north';
use constant SOUTH => 'south';
use constant EAST  => 'east';
use constant WEST  => 'west';
use constant UP    => 'north';
use constant DOWN  => 'south';
use constant LEFT  => 'west';
use constant RIGHT => 'east';

our @EXPORT = qw(NORTH SOUTH EAST WEST UP DOWN LEFT RIGHT);

sub reverse {
  my $direction = shift;

  return SOUTH if $direction eq NORTH;
  return NORTH if $direction eq SOUTH;
  return WEST if $direction eq EAST;
  return EAST if $direction eq WEST;
}

sub rotate {
  my ($direction, $clockwise) = @_;

  if ($direction eq NORTH) {
    $direction = EAST;
  }
  elsif ($direction eq SOUTH) {
    $direction = WEST;
  }
  elsif ($direction eq WEST) {
    $direction = NORTH;
  }
  elsif ($direction eq EAST) {
    $direction = SOUTH;
  }
  else {
    die "No such 2D direction '$direction'";
  }

  if (!$clockwise) {
    $direction = Arkess::Direction::2D::reverse($direction);
  }
  return $direction;
}

1;

__END__
=head1 NAME
Arkess::Direction::3d - Movement in any direction
