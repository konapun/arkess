package Arkess::Component::WarpPoint;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Collidable'
  ];;
}

sub initialize {
  my ($self, $x, $y, $width, $height) = @_;


}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setCollisionTag('warpPoint');
  $cob->onCollision(sub {
    print "WARPING!\n";
  });
}
1;
