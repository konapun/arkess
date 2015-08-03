package ClickQuest::UI::Frame;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ]
}

sub initialize {
  print "INIT!\n";
}

sub finalize {
  my ($self, $cob) = @_;

  $cob->setZIndex(999);
}

sub exportMethods {
  my $self = shift;

  return {
    render => sub {
      print "Rendering\n";
    }
  };
}

1;
