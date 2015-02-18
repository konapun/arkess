package Arkess::Component::Describable;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $description) = @_;

  $self->{description} = $description;
}

sub exportMethods {
  my $self = shift;

  return {

    setDescription => sub {
      my ($self, $desc) = @_;

      $self->{description} = $desc;
    },

    getDescription => sub {
      return $self->{description};
    }

  };
}

1;
