package Arkess::Component::TextBased::Describable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable'
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
      return shift->get('description');
    },

    setDescription => sub {
      my ($cob, $description) = @_;
      $cob->set('description', $description);
    }
  }
}

1;
