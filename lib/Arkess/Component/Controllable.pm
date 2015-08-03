package Arkess::Component::Controllable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

die "Don't use this yet (sorry)";
  $self->{controller} = $controller;
  $self->{deferred} = [];
}

sub exportMethods {
  my $self = shift;

  return {

    getController => sub {
      return $self->{controller}
    },

    whenControllerAvailable => sub {
      my ($cob, $sub) = @_;

      push(@{$self->{deferred}}, $sub);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  if (!$self->{controller}) {
    $cob->whenRuntimeAvailable(sub {
      my $runtime = shift;

      my $controller = $runtime->createController($cob);
      foreach my $deferred (@{$self->{deferred}}) {
        $deferred->($controller);
      }
      $self->{controller} = $controller;
    });
  }
}

1;
__END__
=head1 NAME
Arkess::Component::Controllable - A component for an object that may be
controlled using and Arkess::IO::Controller
