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

  return {

    setHolder => sub {
      my ($cob, $holder) = @_;

      $self->{holder} = $holder;
    },

    removeHolder => sub {
      $self->{holder} = undef;
    },

    getHolder => sub {
      return $self->{holder};
    },

    isBeingHeld => sub {
      return defined $self->{holder};
    }
  }
}
1;
