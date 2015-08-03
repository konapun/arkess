package ClickQuest::ClickCanvas;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Clickable', # TODO
    'Arkess::Component::Renderable'
  ];
}

1;
