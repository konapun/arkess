package Arkess::Component::2D::Line;

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
  $from = [0, 0] unless defined $from;
  $to = [100, 100] unless defined $to;
  $self->{from} = $from;
  $self->{to} = $to;
  $self->{color} = $color;
}

sub exportMethods {
  my $self = shift;

  return {

    getFrom => sub {
      my $from = $self->{from};
      return ($from->[0], $from->[1]);
    },

    getTo => sub {
      my $to = $self->{to};
      return ($to->[0], $to->[1]);
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
