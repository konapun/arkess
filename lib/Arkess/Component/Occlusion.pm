package Arkess::Component::Occlusion;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{occlusionEvents} = [];
  $self->{isOccluded} = 0;
}

sub exportMethods {
  my $self = shift;

  return {

    isOccluded => sub {
      return $self->{isOccluded};
    },

    whenOccluded => sub {
      my ($self, $callback) = @_;

      push(@{$self->{occlusionEvents}}, $callback);
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  # Set event that checks for occlusion. When an occlusion is detected, trigger
  # the occlusion callbacks passing in the occluder (so that its transparency
  # can be altered, for instance)
  # TODO: Check for occlusion by using z-index and screen coordinates
}

1;
