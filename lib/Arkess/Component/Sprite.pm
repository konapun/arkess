package Arkess::Component::Sprite;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {

}

sub exportAttributes {
  return {
    spriteSheet => undef
  };
}

sub exportMethods {
  return {
    render => sub {
      my $cob = shift;

      print "Rendering!\n";
    }
  };
}

1;
