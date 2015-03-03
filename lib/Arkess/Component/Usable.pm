package Arkess::Component::Usable;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $action) = @_;

  $self->{action} = $action || sub{}; # NOP
}

sub exportMethods {
  my $self = shift;

  return {

    onUse => sub {
      my ($cob, $sub) = @_;

      $self->{action} = $sub;
    },

    use => sub {
      my @args = @_;

      if (!$self->{action}) {
        die "Action not provided for 'use' - pass one in initialize or add it using `onUse`";
      }
      return $self->{action}->(@args);
    }

  };
}

1;
