package Arkess::Component::Describable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $description) = @_;

  $description = "" unless defined $description;
  $self->{description} = $description;
}

sub exportAttributes {
  my $self = shift;

  return {
    description => $self->{description}
  }
}

sub exportMethods {
  return {

    getDescription => sub {
      my $cob = shift;

      return $cob->get('description');
    },

    setDescription => sub {
      my ($cob, $description) = @_;

      $cob->set('description', $description);
    }
  }
}

1;
