package Arkess::Component::Actioned;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my $self = shift;

  $self->{abilities} = {};
}

sub exportMethods {
  my $self = shift;

  return {

    addAction => sub {
      my ($cob, $name, $sub, $enabled) = @_;

      $enabled = 1 unless defined $enabled;
      $self->{abilities}->{$name} = {
        action  => $sub,
        enabled => $enabled
      };
    },

    getActions => sub {
      return $self->{abilities};
    },

    doesActionExist => sub {
      my ($cob, $name) = @_;

      return defined $self->{abilities}->{$name};
    },

    isActionEnabled => sub {
      my ($cob, $name) = @_;

      return 0 unless $cob->doesActionExist($name);
      return $self->{abilities}->{$name}->{enabled};
    },

    removeAction => sub {
      my ($cob, $name) = @_;

      die "TODO";
    },

    disableAction => sub {
      my ($cob, $name) = @_;

      return unless $cob->doesActionExist($name);
      $self->{abilities}->{$name}->{enabled} = 0;
    },

    enableAction => sub {
      my ($cob, $name) = @_;

      return unless $cob->doesActionExist($name);
      $self->{abilities}->{$name}->{enabled} = 1;
    },

    callAction => sub {
      my ($cob, $action, @args) = @_;

      if ($cob->isActionEnabled($action)) {
        return $self->{abilities}->{$action}->{action}->(@args);
      }
    }

  };
}

1;
__END__
=head1 NAME
Arkess::Component::Actioned - A component for assigning/removing actions from
an entity, such as learning new abilities or disabling current abilities
