package ClickQuest::ClickCanvas;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Clickable', # TODO
    'Arkess::Component::Renderable'
  ];
}

sub finalize {
  my ($self, $cob) = @_;

  
}
1;
