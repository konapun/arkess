package AutumnDay::Item::CaramelApple;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'AutumnDay::Component::Food'
  ];
}

sub afterInstall {
  my ($self, $cob) = @_;

}

1;
