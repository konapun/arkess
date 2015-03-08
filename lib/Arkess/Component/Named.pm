package Arkess::Component::Named;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $name) = @_;

  $self->{name} = $name;
}

sub exportMethods {
  my $self = shift;

  return {

    setName => sub {
      my ($cob, $name) = @_;

      $self->{name} = $name;
    },

    getName => sub {
      return $self->{name};
    }

  };
}

1;
