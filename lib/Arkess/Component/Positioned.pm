package Arkess::Component::Positioned;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D::Point'
  ];
}

sub initialize {
  my ($self, $x, $y, $direction) = @_;

  $self->{x} = defined($x) ? $x : -1;
  $self->{y} = defined($y) ? $y : -1;
  print "Initializing with (" . $self->{x} . ", " . $self->{y} . ")\n";
  $self->{direction} = defined $direction ? $direction : Arkess::Direction::DOWN;
}

sub configure {
  my ($self, $cob) = @_;

  my ($x, $y) = $cob->getCoordinates();
  if ($self->{x} < 0) {
    $self->{x} = $x;
  }
  if ($self->{y} < 0) {
    $self->{y} = $y;
  }
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setCoordinates($self->{x}, $self->{y});
}

sub exportMethods {
  my $self = shift;

  return {

    setDirection => sub {
      my ($cob, $direction) = @_;

      $self->{direction} = $direction;
    },

    getDirection => sub {
      return $self->{direction};
    },

    getDistanceFrom => sub {
      my ($cob, $cob2, $abs) = @_;

      die "Can't get distance from unpositioned object" unless $cob2->hasMethod('getDistanceFrom');
      my ($x1, $y1) = $cob->getCoordinates();
      my ($x2, $y2) = $cob2->getCoordinates();
      my $distanceX = $x2 - $x1;
      my $distanceY = $y2 - $y1;
      if ($abs) {
        $distanceX = abs $distanceX;
        $distanceY = abs $distanceY;
      }

      return ($distanceX, $distanceY);
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Positioned - A component for entities who occupy space in the
game world
