package Arkess::Component::CameraFollow;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable' # FIXME: breaks move when installed
  ];
}

sub initialize {
  my ($self, $followType) = @_; # TODO: Export follow types

  $followType ||= 'scroll'; # when the followed character becomes out of bounds, transition the whole screen
  $self->{followType} = $followType;
}

sub setPriority {
  return 1;
}

sub afterInstall {
  my ($self, $cob) = @_;

print "Setting up events!\n";
# TODO
  $cob->on('move', sub { # FIXME: this should be auto-triggered but it's not, probably because of the FIXME above
    print "MOVING!\n";
  });

#  $cob->on('setRuntime', sub {
#    $cob->on(Arkess::Event::LOOP_START, sub { # FIXME - only for testing
#      $cob->move('down');
#    });
#  });
}

1;
__END__
=head1 NAME
Arkess::Component::CameraFollow - Keep a mobile entity in the center of the
screen
