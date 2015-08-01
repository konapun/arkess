package Arkess::Component::CoordinateZIndex;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Positioned',
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $orientation) = @_;

  $orientation ||= 'bottom';
  $self->{orientation} = $orientation; # FIXME
}

sub finalize {
  my ($self, $cob) = @_;

  my $baseIndex = $cob->getZIndex();
  $cob->on('setCoordinates', sub {
    $cob->setZIndex($cob->getY() + $baseIndex);
  });
}
1;

__END__
=head1 NAME
Arkess::Component::CoordinateZIndex - Automatically handle overlap based on
coordinates
