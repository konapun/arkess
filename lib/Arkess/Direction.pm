package Arkess::Direction;

use strict;
use base qw(Exporter);

use constant UP    => 'up';
use constant DOWN  => 'down';
use constant LEFT  => 'left';
use constant RIGHT => 'right';

our @EXPORT = qw(UP DOWN LEFT RIGHT);

sub reverse {
  my $direction = shift;

  return DOWN if $direction eq UP;
  return UP if $direction eq DOWN;
  return RIGHT if $direction eq LEFT;
  return LEFT if $direction eq RIGHT;
}

sub rotate {
  my ($direction, $clockwise) = @_;

  $direction = RIGHT if $direction eq UP;
  $direction = LEFT if $direction eq DOWN;
  $direction = UP if $direction eq LEFT;
  $direction = DOWN if $direction eq RIGHT;
  
  if (!$clockwise) {
    $direction = Arkess::Direction::reverse($direction);
  }
  return $direction;
}

1;

__END__
=head1 NAME
Arkess::Direction - Auto-exported directions enum for Arkess
