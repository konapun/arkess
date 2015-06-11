package Test::Named;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $name) = @_;

  $self->{name} = defined $name ? $name : '(unknown)';
}

sub exportMethods {
  my $self = shift;

  return {

    getName => sub {
      return $self->{name};
    },

    setName => sub {
      my ($cob, $name) = @_;

      $self->{name} = $name;
    }

  };
}

1;
