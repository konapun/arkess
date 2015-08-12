package ClickQuest::UI::Frame;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Container',
    'Arkess::Component::2D'
  ]
}

sub initialize {
  my ($self, $width, $height);

  $self->{width} = $width;
  $self->{height} = $height;
}

sub finalize {
  my ($self, $cob) = @_;

  $self->{width} = 700;
  $self->{height} = 500;
  $cob->setZIndex(1);
  $cob->setCoordinates(0, 0);
  $cob->setDimensions($self->{width}, $self->{height});

  my $padding = 100;
  my $canvas = $cob->addToContainer(Arkess::Object->new({
    'ClickQuest::UI::ClickCanvas' => [$padding, $padding, $self->{width} - 2*$padding, $self->{height} - 2*$padding]
  }));
  my $button = $cob->addToContainer(Arkess::Object->new({
    'Arkess::Component::UI::Button' => 'test'
  }));
  $button->setColor([255,0,255]);
  $button->onClick(sub {
    # spawn something on the canvas
    print "Clicked button!\n";
  });

  my $oldColor = $button->getColor();
  $button->onHover(sub {
    $button->setColor([255,100,255]);
  });
  $button->onUnhover(sub {
    $button->setColor($oldColor);
  });
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
