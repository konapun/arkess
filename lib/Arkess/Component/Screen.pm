package Arkess::Screen;

use strict;

sub new {
  my $package = shift;
  my ($map, $x, $y, $width, $height) = @_;

  return bless {
    map    => $map,
    x      => $x,
    y      => $y,
    width  => $width,
    height => $height
  }, $package;
}


sub getCoordinates {
  my $self = shift;

  return {
    x => $self->{x},
    y => $self->{y}
  };
}

sub setCoordinates {
  my ($self, $x, $y) = @_;


  # TODO: Error checking
  $self->{x} = $x;
  $self->{y} = $y;
  return 1; # success
}

1;
