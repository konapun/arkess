package Arkess::Component::Renderable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable',
  ];
}

sub initialize {
  my ($self, $renderer, $zlayer) = @_;

  $self->{renderer} = $renderer;
  $self->{x} = 0;
  $self->{y} = 0;
  $self->{zlayer} = defined $zlayer ? $zlayer : 1;
  $self->{width} = 160;
  $self->{height} = 160;
  $self->{hidden} = 0;
}

sub exportAttributes {
  return {
    renderable => 1 # needed in order to be picked up by the rendering engine
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setZIndex => sub {
      my ($cob, $layer) = @_;

      $self->{zlayer} = $layer;
    },

    setScreenX => sub {
      my ($cob, $x) = @_;

      $self->{x} = $x;
    },

    setScreenY => sub {
      my ($cob, $y) = @_;

      $self->{y} = $y;
    },

    getScreenX => sub {
      return $self->{x};
    },

    getScreenY => sub {
      return $self->{y};
    },

    setScreenCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $cob->setScreenX($x);
      $cob->setScreenY($y);
    },

    getScreenCoordinates => sub {
      my $cob = shift;

      return [$cob->getScreenX(), $cob->getScreenY()];
    },

    getZIndex => sub {
      return $self->{zlayer};
    },

    setRenderer => sub {
      my ($cob, $renderer) = @_;

      $self->{renderer} = $renderer;
    },

    getRenderer => sub {
      return $self->{renderer};
    },

    hide => sub {
      $self->{hidden} = 1;
    },

    unhide => sub {
      $self->{hidden} = 0;
    },

    toggleVisibility => sub {
      $self->{hidden} = !$self->{hidden};
    },

    isHidden => sub {
      return $self->{hidden};
    },

    render => sub {
      # pass - not implemented here
    }

  }
}

sub afterInstall {
  my ($self, $cob) = @_;

  if ($cob->hasMethod('getCoordinates')) {
    $cob->setScreenCoordinates($cob->getX(), $cob->getY()); # Make screen coords same as internal coords if they exist
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Renderable - A component required by any entity which draws
to the screen
