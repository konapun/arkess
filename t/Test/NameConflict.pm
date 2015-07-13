package Test::NameConflict;

use strict;
use base qw(Arkess::Component);

sub setPriority {
  return 100;
}

sub initialize {
  my ($self, $name) = @_;

  $self->{name} = defined $name ? $name : '(unknown)';
}

sub exportMethods {
  my $self = shift;

  return {

    getName => sub {
      return "CONFLICTING: " . $self->{name};
    },

    setName => sub {
      my ($cob, $name) = @_;

      $self->{name} = $name;
    }

  };
}

1;
