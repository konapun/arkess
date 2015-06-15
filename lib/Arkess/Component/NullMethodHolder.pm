package Arkess::Component::NullMethodHolder;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $methods) = @_; # Optionally pass a list of methods to create null versions of

  if (ref $methods eq 'Arkess::Object') { # nullify from another object
    $self->{initFrom} = $methods;
    $methods = [];
  }

  $methods ||= [];
  $self->{methods} = $methods;
}

sub exportMethods {
  return {

    # Make a null method with an optional return type
    nullMethod => sub {
      my ($cob, $methodName, $rval) = @_;

      $rval = 0 unless defined $rval;
      $cob->methods->set($methodName, sub {
        return $rval;
      });
    },

    # Add null methods for all missing methods from another cob
    nullifyMissingFrom => sub {
      my ($thisCob, $otherCob) = @_;

      $otherCob->methods->each(sub {
        my ($key, $val) = @_;

        unless ($thisCob->methods->has($key)) {
          $thisCob->nullMethod($key);
        }
      });
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->nullifyMissingFrom($self->{initFrom}) if defined $self->{initFrom};
  foreach my $method (@{$self->{methods}}) { # nullify any methods passed during init
    $cob->nullMethod($method);
  }
}

1;
