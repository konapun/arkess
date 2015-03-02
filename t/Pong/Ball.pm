package Pong::Ball;

use strict;
use SDLx::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Collidable',
    'Arkess::Component::Renderable',
    'Arkess::Component::Timed',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my $self = shift;

  $self->{maxVelocity} = 10;
  $self->{v_x} = -2.7;
  $self->{v_y} = 1.8;
  $self->{origin} = undef;
  $self->{color} = [255, 255, 255, 255];
  $self->{radius} = 5;
  $self->{angle} = 0;
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->setCollisionTag('ball');
  $cob->collideWith('paddle', sub {
#    die "BALL COLLIDED WITH PADDLE!\n";
  });
  $cob->collideWith('ball', sub {
#    die "BALL COLLIDED WITH BALL!\n";
  });

  $cob->on('setRuntime', sub {
    $cob->registerTimedEvent(sub {
      $self->{color} = [int(rand(256)), int(rand(256)), int(rand(256)), 255];
    }, 500);
  });
}

sub exportMethods {
  my $self = shift;

  my $position = $self->{position};
  return {

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $self->{origin} = [$app->w/2, $app->h/2] unless defined $self->{origin};
      $cob->setCoordinates(@{$self->{origin}});
      $app->draw_circle_filled($self->{origin}, $self->{radius}, $self->{color});

      my ($x, $y) = @{$self->{origin}};
      if ($x <= 0) {
        $self->{v_x} += 2 unless $self->{v_x} >= $self->{maxVelocity};
        $self->{v_x} *= -1;
        $self->{angle} = rand(10);
        $self->{angle} *= -1 if rand(10) > 5;
      }
      if ($x >= $app->w) {
        $self->{v_x} -= 2 unless $self->{v_x} >= $self->{maxVelocity};
        $self->{v_x} *= -1;
        $self->{angle} = rand(10);
        $self->{angle} *= -1 if rand(10) > 5;
      }
      if ($y <= 0) {
        $self->{v_y} = 0;
        $self->{angle} *= -1;
      }
      if ($y >= $app->h) {
        $self->{v_y} = $app->h;
        $self->{angle} *= -1;
      }
      $self->{origin} = [$x-$self->{v_x}, $y+$self->{angle}];
      print "Rendering ball at ($x, $y) ($cob)\n";
    }

  };
}

1;
