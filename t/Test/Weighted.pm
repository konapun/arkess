package Test::Weighted;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $weight) = @_;

  $self->{weight} = defined $weight ? $weight : 10;
}

sub exportMethods {
  my $self = shift;

  return {

    getWeight => sub {
      return $self->{weight};
    },

    setWeight => sub {
      my ($cob, $age) = @_;

      $self->{weight} = $age;
    }

  };
}

1;
