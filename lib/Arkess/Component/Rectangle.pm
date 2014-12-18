package Arkess::Component::Rectangle;

use strict;
use SDL::Rect;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $width, $height) = @_;

  die "Must provide width and height" unless defined $width && defined $height;
}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;

      print "RENDERING RECT\n";
    }

  };
}

1;
