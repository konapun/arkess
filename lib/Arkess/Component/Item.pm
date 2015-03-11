package Arkess::Component::Item;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Named',
    'Arkess::Component::Takeable'
  ];
}

sub exportMethods {
  my $self = shift;

  return {

    use => sub {
      die "Arkess::Component::Item does not implement `use`";
    }

  };
}

1;

__END__
=head1 NAME
Arkess::Component::Item - Base component for an item
