package ClickQuest::UI::ClickCanvas;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Clickable',
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $x, $y, $width, $height) = @_;

  $self->{x} = $x;
  $self->{y} = $y;
  $self->{width} = $width;
  $self->{height} = $height;
}

sub configure {
  my ($self, $cob) = @_;

  $cob->setCoordinates($self->{x}, $self->{y});
  $cob->setDimensions($self->{width}, $self->{height});
}

sub exportMethods {
  return {

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_rect([$cob->getX(), $cob->getY(), $cob->getWidth(), $cob->getHeight()], [0, 0, 255]);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setCoordinates($self->{x}, $self->{y});
  $cob->setDimensions($self->{width}, $self->{height});

  $cob->onClick(sub {
    my $event = shift;

    print "GOT CLICK!\n";
  });
  $cob->onDrag(sub {
    my ($eventStart, $eventEnd) = @_;

    print "GOT DRAG!\n";
  });
}

1;
