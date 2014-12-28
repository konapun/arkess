package Arkess::Component::Mobile;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned'
  ];
}

sub initialize {
  my ($self, $units) = @_;

  $self->{units} = defined $units ? $units : 1; # How many units to move on strafe or move
}

sub exportMethods {
  my $self = shift;

  return {

    # Move without changing direction
    # Return true or false depending on whether or not the cob was able to move
    strafe => sub {
      my ($cob, $direction, $facing) = @_;

      my ($x, $y) = $cob->getCoordinates();
      my $units = $self->{units};
      my $facing = $cob->getDirection() unless defined $facing;
      if ($direction eq Arkess::Direction::DOWN) {
        $y += $units;
      }
      elsif ($direction eq Arkess::Direction::UP) {
        $y -= $units;
      }
      elsif ($direction eq Arkess::Direction::LEFT) {
        $x -= $units;
      }
      elsif ($diretion eq Arkess::Direction::RIGHT) {
        $x += $units;
      }
      else {
        die "Unknown direction";
      }

      $cob->setCoordinates($x, $y);
      $cob->setDirection($facing);
      return 1;
    },

    # Move while changing position
    move => sub {
      my ($cob, $direction) = @_;

      my $success = $cob->strafe($direction, $direction);
      $cob->trigger('move', [$direction]) if $success;
      return $success;
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Mobile - A component for objects that can move around
