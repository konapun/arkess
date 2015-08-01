package Arkess::Component::BackgroundImage;

use strict;
use Arkess::Event;
use Arkess::Component::Image;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $src) = @_;

  my $image = Arkess::Component::Image->new($src);
  $self->{imgComponent} = $image;
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->installComponent($self->{imgComponent});
  $cob->on(Arkess::Event::RUNTIME_START, sub {
    my $options = $cob->getRuntime()->getRenderer()->getWindowOptions();

    $cob->setDimensions($options->{width}, $options->{height});
  });
}

1;
