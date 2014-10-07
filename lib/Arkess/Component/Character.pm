package Arkess::Component::Character;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Named',
    'Arkess::Component::Mortal',
    'Arkess::Component::Mobile'
  ];
}

1;

__END__
=head1 NAME
Arkess::Component::Character - base includes for a character
