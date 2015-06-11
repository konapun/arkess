package Arkess::Component::UI::Canvas;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $width, $height) = @_;
  $width = $self->getWidth() unless $width; # stretch over entire render layer
  $height = $self->getHeight() unless $height;

  $self->setWidth($width);
  $self->setHeight($height);
}

sub exportMethods {
  my $self = shift;

  return {

  };
}

1;
__END__
=head1 NAME
Arkess::Component::UI::Canvas - An overlay for the main render
