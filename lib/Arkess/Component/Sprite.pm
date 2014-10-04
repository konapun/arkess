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
    spriteSheet => undef,
    sequences => {}, # map of names to frameseqs
  };
}

sub exportMethods {
  return {
    setSequences => sub {
      
    },
    
    sub setSequence => sub {
      my ($cob, $name, $frames) = @_;
      
    },
    
    render => sub {
      my $cob = shift;

      print "Rendering!\n";
    }
  };
}

1;
