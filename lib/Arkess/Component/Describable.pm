package Arkess::Component::Describable;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $description, $shortDescription) = @_;

  $self->{description} = $description;
  $self->{shortDescription} = $shortDescription;
}

sub exportAttributes {
  return {
    describable => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setDescription => sub {
      my ($cob, $desc) = @_;

      $self->{description} = $desc;
    },

    setShortDescription => sub {
      my ($cob, $desc) = @_;

      $self->{shortDescription} = $desc;
    },

    getDescription => sub {
      return $self->{description};
    },

    getShortDescription => sub {
      return $self->{shortDescription};
    }

  };
}

1;
