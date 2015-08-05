package Arkess::Component::Container;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::RuntimeAware',
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my $self = shift;

  $self->{components} = [];
  $self->{oldRender} = undef;
}

sub configure {
  my ($self, $cob) = @_;

  $self->{oldRender} = $cob->methods->get('render');
}

sub exportMethods {
  my $self = shift;

  return {

    addToContainer => sub {
      my ($cob, $renderable) = @_;

      die "Can only add renderables to container" unless $renderable->attributes->has('renderable');
      push(@{$self->{components}}, $renderable);
      return $renderable;
    },

    removeFromContainer => sub {
      my ($cob, $renderable) = @_;

      # TODO
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  foreach my $component (@{$self->{components}}) {
    $component->setZIndex($component->getZIndex() + $cob->getZIndex());
  }

  $cob->whenRuntimeAvailable(sub {
    my $runtime = $cob->getRuntime();

    foreach my $obj (@{$self->{components}}) {
      $obj->setRuntime($runtime);
    }
  });

  # Modify render to render the container and all its children
  $cob->on(Arkess::Event::BEFORE_RENDER, sub {
    $cob->render();
    foreach my $component (@{$self->{components}}) {
      $component->setRenderer($cob->getRenderer());
      $component->render();
    }
  });
}

1;
