package Arkess::Component::TextBased::Item;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Named', # how this item is identifier (e.g. "icecream")
    'Arkess::Component::Describable', # description used when examining this item
    'Arkess::Component::Actioned' # actions this item accepts (e.g. "eat icecream")
  ];
}

sub exportAttributes {
  return {
    visible => 1
  };
}

1;
