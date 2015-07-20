package Arkess::Component::2D;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::2D::Point' => [0, 0]
  };
}

sub initialize {
  my ($self, $width, $height) = @_;

  # FIXME: component this gets intalled into might already have these set (if it's being reinstalled)
  $self->{width} = defined $width ? $width : 100;
  $self->{height} = defined $height ? $height : 100;
}

sub beforeInstall {
  my ($self, $cob) = @_;

  if ($cob->can('getWidth') && $cob->can('getHeight')) { # Don't overwrite these
    $self->{width} = $cob->getWidth();
    $self->{height} = $cob->getHeight();
  }
}

sub exportMethods {
  my $self = shift;

  return {

    getWidth => sub {
      return $self->{width}
    },

    getHeight => sub {
      return $self->{height};
    },

    getDimensions => sub {
      return ($self->{width}, $self->{height});
    },

    setWidth => sub {
      my ($cob, $width) = @_;

      $self->{width} = $width;
    },

    setHeight => sub {
      my ($cob, $height) = @_;

      $self->{height} = $height;
    },

    setDimensions => sub {
      my ($cob, $width, $height) = @_;

      $cob->setWidth($width);
      $cob->setHeight($height);
    }

  };
};

1;
__END__
=head1 NAME
Arkess::Component::Sized - a component for entities which have (width, height)
dimensions
