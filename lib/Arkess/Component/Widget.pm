package Arkess::Component::Widget;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $player) = @_;

  $self->{player} = shift;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_rect([$cob->getX(), $cob->getY(), $cob->getWidth(), $cob->getHeight()], [2, 20, 100, 0]);
    }

  };
}
1;
