package Arkess::Component::Actioned;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $actions) = @_;

  $self->{initActions} = $actions || {}; # hashref of action names to actions
  $self->{abilities} = {};
}

sub configure {
  my ($self, $cob) = @_;

  if ($cob->hasAttribute('actioned')) {
    print "HERE\n";
    $self->{abilities} = $cob->getActions();
  }
}

sub exportAttributes {
  return {
    actioned => 1
  };
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

    wrapAsActioned => sub {
      my ($cob, $actions) = @_;

      foreach my $action (@$actions) {
        my $sub = $cob->methods->get($action);
        $cob->addAction($action, sub {
          return $sub->call(@_);
        });
      }
    },

    getActions => sub {
      return $self->{abilities}; # FIXME - only return names
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
        $cob->trigger($action, @args);
        return $self->{abilities}->{$action}->{action}->($cob, @args);
      }
    },

    beforeAction => sub {
      my ($cob, $actionName, $callback) = @_;

      $cob->before($actionName, $callback);
    },

    onAction => sub {
      my ($cob, $actionName, $callback) = @_;

      $cob->on($actionName, $callback);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  my %initActions = %{$self->{initActions}};
  foreach my $actionName (keys %initActions) { # install actions from initialize if any
    $cob->addAction($actionName, $initActions{$actionName});
  }
}

1;
__END__
=head1 NAME
Arkess::Component::Actioned - A component for assigning/removing actions from
an entity, such as learning new abilities or disabling current abilities
