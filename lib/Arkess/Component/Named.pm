package Arkess::Component::Named;

use strict;
use base qw(Cobsy::Component);

sub requires {
  return [
    'Arkess::Component::Getter'
  ];
}

sub exportAttributes {
  return {
    name => '(unknown')
  };
}

sub exportMethods {
  return {
    getName => sub {
      return shift->get('name');
    }
  };
}

1;
