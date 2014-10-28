package Arkess::Component::RuntimeAware;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $runtime) = @_;

  $self->{runtime} = $runtime;
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

      die "Runtime already set" if defined $self->{runtime};
      print "Setting runtime\n";
      $self->{runtime} = $runtime;
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
    }

  };
}

1;

__END__

=head1 NAME
Arkess::Component::RuntimeAware - A component for entities which are aware of
the runtime (installed by default in all Arkess entities)
