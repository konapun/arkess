package Arkess::Component::CameraFollow;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile',
#    'Arkess::Component::Observable' # FIXME: breaks move when installed
  ];
}

sub setPriority {
  return 2;
}

sub afterInstall {
  my ($self, $cob) = @_;

print "Setting up events!\n";
# TODO
  $cob->on('move', sub { # FIXME: this should be auto-triggered but it's not, probably because of the FIXME above
    print "MOVING!\n";
  });
}

1;
__END__
=head1 NAME
Arkess::Component::CameraFollow - Keep a mobile entity in the center of the
screen
