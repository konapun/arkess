package Arkess::Component::Deactivatable;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{inactive} = {}; # store the originals here so they can be restored
}

sub exportMethods {
  my $self = shift;

  return {

    activate => sub {
      my ($cob, $method) = @_;

      if (defined $self->{inactive}->{$method}) {
        my $cb = $self->{inactive}->{$method};
        $cob->methods->set($method, sub { # restore the previous version
          $cb->call(@_);
        });
        delete $self->{inactive}->{$method};
      }
    },

    deactivate => sub {
      my ($cob, $method) = @_;

      unless (defined $self->{inactive}->{$method}) {
        $self->{inactive}->{$method} = $cob->methods->get($method);
        $cob->methods->set($method, sub{});
      }
    }
  }
}

1;
__END__
=head1 NAME
Arkess::Component::Deactivatable - Allow methods to be deactivated by replacing
them with a NOP
