package Arkess::Component::TextBased::Room;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityHolder',
    'Arkess::Component::Linked',
    'Arkess::Component::Describable' # description player will get when looking
  ];
}


1;
