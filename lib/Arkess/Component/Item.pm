package Arkess::Component::Item;

use strict;
use base qw(Arkess::Component);

sub exportAttributes {
  return {
    owner => undef
  };
}

sub exportMethods {

  setOwner => sub {
    my ($cob, $owner) = @_;

    $cob->set('owner', $owner);
  },

  use => sub {
    die "Arkess::Component::Item does not implement `use`";
  }
}
1;

__END__
=head1 NAME
Arkess::Component::Item - Base component for an item
