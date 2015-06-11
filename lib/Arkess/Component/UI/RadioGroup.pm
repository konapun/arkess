package Arkess::Component::RadioGroup;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::UI::Widget'
  ];
}

sub initialize {
  my ($self, $canvas) = @_;

  if (!defined $canvas) {
    # Find it
  }
  $self->{canvas} = $canvas;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {

    }

  }
}

1;
