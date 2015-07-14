package AutumnDay::Component::LiquidHolder;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{contents} = undef;
}

sub exportMethods {
  my $self = shift;

  return {

    fill => sub {
      my ($cob, $liquid) = @_;

      if ($liquid->hasAttribute('liquid')) {
        $self->{contents} = $liquid;
        return 1;
      }
      return 0;
    },

    isFull => sub {
      return defined $self->{contents};
    },

    isEmpty => sub {
      my $cob = shift;

      return !$cob->isFull();
    },

    empty => sub {
      my $contents = $self->{contents};

      $self->{contents} = undef;
      return $contents;
    }
    
  };
}

1;
