package Pong::Goal;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Collidable'
  ];
}

sub initialize {
  my ($self, $direction) = @_;

  die "Must provide direction" unless defined $direction;
  die "Bad direction given" unless $direction eq Arkess::Direction::LEFT || $direction eq Arkess::Direction::RIGHT;
  $self->{direction} = $direction;
}

sub afterInstall {
  my ($self, $cob) = @_;

  if ($direction eq Arkess::Direction::LEFT) {
    # TODO
  }
  elsif ($direction eq Arkess::Direction::RIGHT) {
    # TODO
  }

  $cob->setCollisionTag('goal');
  $cob->collideWith('ball', sub {
    print "SCORED GOAL!\n";
  });
}

1;
