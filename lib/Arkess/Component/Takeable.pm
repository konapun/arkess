package Arkess::Component::Takeable;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{holder} = undef;
}

sub exportAttributes {
  return {
    'takeable' => 1
  };
}

sub exportMethods {
  my $self = shift;

  # TODO
}
1;
