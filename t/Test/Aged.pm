package Test::Aged;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $age) = @_;

  $self->{age} = defined $age ? $age : 10;
}

sub exportMethods {
  my $self = shift;

  return {

    getAge => sub {
      return $self->{age};
    },

    setAge => sub {
      my ($cob, $age) = @_;

      $self->{age} = $age;
    }

  };
}

1;
