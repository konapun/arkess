package ClickQuest::UI::Frame;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Container'
  ]
}

sub initialize {
  print "INIT!\n";
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setZIndex(999);
  $cob->addToContainer(Arkess::Object->new({
    'ClickQuest::UI::ClickCanvas' => [50, 50, 200, 200]
  }));
}

sub exportMethods {
  my $self = shift;

  return {
    render => sub {
      my $cob = shift;
      my $app = $cob->getRenderer();

      #$app->draw_rect([0, 0, $app->w, $app->h], [255, 0, 0]);
    }
  };
}

1;
