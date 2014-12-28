package Arkess::Component::Collidable;

use strict;
use Arkess::Event;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable',
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
    $cob->on('setRuntime', sub {
      my $runtime = shift;

      $runtime->getEventBus()->bind(Arkess::Event::BEFORE_RENDER, sub {
        my ($x, $y) = $cob->getCoordinates();
        my ($width, $height) = $cob->getDimensions();

        foreach my $entity ($runtime->getEntities()) {
          next if $entity == $cob;
          if ($entity->hasAttribute('collidable')) {
            my ($x2, $y2) = $entity->getCoordinates();
            my ($width2, $height2) = $entity->getDimensions();

            if ($x2 >= $x && $x2 <= $x + $width && $y2 >= $y && $y2 <= $y + $width) {
              print "COLLIDE (" . $x2 . ", ". $y2 . ") vs ($x, $y)\n";
            }
          }
        }
      });
    });
  }
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
