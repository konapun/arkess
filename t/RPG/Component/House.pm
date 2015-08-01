package RPG::Component::House;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::Positioned' => [0, 0],
    'Arkess::Component::Image'      => './assets/sprites/house.png',
    'Arkess::Component::Collidable' => [undef, 'house']
  };
}

sub initialize {
  my ($self, $x, $y) = @_;

  $x ||= 0;
  $y ||= 0;
  $self->{x} = $x;
  $self->{y} = $y;
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setCoordinates($self->{x}, $self->{y});
}

1;
