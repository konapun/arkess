package Arkess::Component::MotionBlur;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile'
  ];
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->on('move', sub {
    print "MOTION BLUR TODO\n";
  });
}

1;
