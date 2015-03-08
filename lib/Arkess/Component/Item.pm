package Arkess::Component::Item;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Takeable'
  ];
}

sub initialize {
  my ($self, $holder) = @_;

  $self->{holder} = $holder;
}

sub exportMethods {
  my $self = shift;

  return {

    setHolder => sub {
      my ($cob, $holder) = @_;

      $self->{holder} = $holder;
    },

    isBeingHeld => sub {
      return defined $self->{holder};
    },

    getHolder => sub {
      return $self->{holder};
    },

    use => sub {
      die "Arkess::Component::Item does not implement `use`";
    }

  }
}

1;

__END__
=head1 NAME
Arkess::Component::Item - Base component for an item
