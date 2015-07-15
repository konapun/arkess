package Arkess::Component::RuntimeAware;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $runtime) = @_;

print "INIT RUNTIMEAWARE\n";
  $self->{runtime} = $runtime;
  $self->{deferred} = []; # Callbacks to run once the runtime is available
}

sub exportAttributes {
  return {
    'runtimeAware' => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setRuntime => sub {
      my ($cob, $runtime) = @_;
      $self->{runtime} = $runtime;
      print "set\n";
    },

    hasRuntime => sub {
      return defined $self->{runtime};
    },

    getRuntime => sub {
      die "No runtime set" unless defined $self->{runtime};
      return $self->{runtime};
    },

    getEventBus => sub {
      die "No runtime set" unless defined $self->{runtime};
      return $self->{runtime}->getEventBus();
    },

    getAllEntities => sub {
      die "No runtime set" unless defined $self->{runtime};
      return $self->{runtime}->getEntities();
    },

    doOnceRuntimeIsAvailable => sub {
      my ($cob, $sub) = @_;

      if ($cob->hasRuntime()) {
        return $sub->();
      }
      else {
        push(@{$self->{deferred}}, $sub);
      }
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->on('setRuntime', sub { # Run deferred callbacks
    foreach my $deferred (@{$self->{deferred}}) {
      print "DEFERRED\n";
      $deferred->();
    }
  });
}

1;

__END__

=head1 NAME
Arkess::Component::RuntimeAware - A component for entities which are aware of
the runtime (installed by default in all Arkess entities)
