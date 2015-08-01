package Arkess::Component::3D;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D'
  ];
}

sub setPriority {
  return 3; # higher priority than 2D so stuff can be overwritten
}

sub initialize {
  my ($self, $x, $y, $z) = @_;

  $self->{x} = $x;
  $self->{y} = $y;
  $self->{z} = $z;
}

sub exportMethods {
  my $self = shift;

  return {

    getDepth => sub {
      return $self->{z};
    },

    getDimensions => sub {
      my $cob = shift;

      return ($cob->getWidth(), $cob->getHeight(), $cob->getDepth());
    },

    setDepth => sub {
      my ($cob, $depth) = @_;

      $self->{z} = $depth;
    },

    setDimensions => sub {
      my ($cob, $x, $y, $z) = @_;

      $cob->setWidth($x);
      $cob->setHeight($y);
      $cob->setDepth($z);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setWidth($self->{x}) if defined $self->{x};
  $cob->setHeight($self->{y}) if defined $self->{y};
  $cob->setDepth($self->{z}) if defined $self->{z};
}

1;
