package Plinko::Component::Shooter;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::Collidable' => [],
    'Arkess::Component::Positioned' => [0, 0],
    'Arkess::Component::2D' => [],
#    'Arkess::Component::Bounded' => [],
    'Arkess::Component::Renderable' => [],
    'Arkess::Component::Automated' => []
  };
}
sub initialize {
  my $self = shift;

  $self->{width} = 100;
  $self->{height} = 100;
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setCoordinates(0, 0);
  $cob->on(Arkess::Event::RUNTIME_START, sub {
    my $options = $cob->getRuntime()->getRenderer()->getWindowOptions();

    my $width = $options->{width};
    $cob->addAutomation('bounce', sub {
      $cob->moveTo($width, 0, sub {
        $cob->moveTo(0, 0);
      });
    });
    #$cob->playAutomation('bounce');
  });
}

sub exportMethods {
  my $self = shift;

  return {

    shoot => sub {
      my $cob = shift;

      my $runtime = $cob->getRuntime();
      my $ball = $runtime->createEntity({
        'Arkess::Component::Circle',
        'Arkess::Component::Positioned',
        'Arkess::Component::2D'
      });
      $ball->setCoordinates($cob->getX(), $cob->getY() + $cob->getHeight() + 100);
    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_rect([$cob->getX(), $cob->getY(), $self->{width}, $self->{height}], [255,255,255]);
    }

  };
}

1;
