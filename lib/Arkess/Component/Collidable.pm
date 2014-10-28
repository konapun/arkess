package Arkess::Component::Collidable;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable' # needed to get screen coordinates to check for collisions
  ];
}

sub initialize {
  my ($self, $runtime) = @_;

  $self->{didCollide} = 0;
  $self->{runtime} = $runtime;
}

sub afterInstall {
  my ($self, $cob) = @_;
  
  my $runtime = $self->{runtime};
  if (!$runtime) {
    if ($cob->hasAttribute('runtimeAware')) {
      $runtime = $cob->getRuntime();
    }
    else {
      die "Runtime needed for component Collidable";
    }
  }

  $runtime->getEventBus()->register(Arkess::Event::BEFORE_RENDER, sub { # Check for collisions
    my ($x, $y) = $self->getScreenCoordinates();
    my ($width, $height) = $self->getDimensions();
    foreach my $entity ($runtime->getEntities()) {
      if ($entity->hasAttribute('collidable')) { # check coordinates
        my ($x2, $y2) = $entity->getScreenCoordinates();
        my ($width2, $height2) = $entity->getDimensions();

        print "Got coords (" . $x2 . ", " . $y2 . ")\n";
      }
    }
  });
}

sub exportAttributes {
  return {
    collidable => 1
  }
}

sub exportMethods {
  return {

    collideOnce => sub {
      # Event called only the first time a collision happens
    },

    collide => sub {
      # Callback triggered each time a collision happens
    }

  };
}

1;
