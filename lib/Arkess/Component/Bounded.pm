package Arkess::Component::Bounded;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $boundsProvider) = @_;

  die "You must provide a component with width and height for component Bounded" unless defined $boundsProvider && $boundsProvider->hasMethod('getHeight');
  $self->{provider} = $boundsProvider;
}

sub finalize {
  my ($self, $cob) = @_;

  my $provider = $self->{provider};
  my ($width, $height) = $provider->getDimensions();
  $cob->on('move', sub {
    my ($x, $y) = $cob->getCoordinates();

    if ($x <= 1) {
      $cob->setX(1);
    }
    elsif ($x >= $width) {
      $cob->setX($width-1);
    }
    if ($y <= 1) {
      $cob->setY(1);
    }
    elsif ($y >= $height) {
      $cob->setY($height-1);
    }

    ($x, $y) = $cob->getCoordinates();
    print "($x, $y)\n";
  });
}

1;
