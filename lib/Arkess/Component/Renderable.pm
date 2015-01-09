package Arkess::Component::Renderable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable',
    'Arkess::Component::Positioned'
  ];
}

sub initialize {
  my ($self, $renderer) = @_;

  $self->{renderer} = $renderer;
  $self->{width} = 160;
  $self->{height} = 160;
}

sub exportAttributes {
  return {
    renderable => 1 # needed in order to be picked up by the rendering engine
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setRenderer => sub {
      my ($cob, $renderer) = @_;

      $self->{renderer} = $renderer;
    },
    
    getRenderer => sub {
      return $self->{renderer};
    },

    #render => sub {
    #  # pass - not implemented here
    #}

  }
}

1;

__END__
=head1 NAME
Arkess::Component::Renderable - A component required by any entity which draws
to the screen
