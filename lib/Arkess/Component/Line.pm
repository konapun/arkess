package Arkess::Component::Line;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable'
  ];
}

sub initialize {
  my ($self, $from, $to, $color) = @_;

  die "Must provide from and to coordinates" unless defined $from && defined $to;
  $color = [255, 255, 0, 255] unless defined $color;
  $self->{from} = $from;
  $self->{to} = $to;
  $self->{color} = $color;
}

sub exportMethods {
  my $self = shift;

  return {

    getFrom => sub {
      return shift->{from};
    },

    getTo => sub {
      return shift->{to};
    },

    setFrom => sub {
      my ($cob, $x, $y) = @_;

      $self->{from} = [$x, $y];
    },

    setTo => sub {
      my ($cob, $x, $y) = @_;

      $self->{to} = [$x, $y];
    },

    setColor => sub {
      my ($cob, $color) = @_;

      $self->{color} = $color;
    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      $app->draw_line($self->{from}, $self->{to}, $self->{color});
    }

  };
}

1;
