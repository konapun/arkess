package Arkess::Component::Wired;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    'wired' => 1
  }
}

sub finalize {
  my ($self, $cob) = @_;

  
}

1;
__END__
=head1 NAME
Arkess::Component::Wired - A component that defines wiring points
