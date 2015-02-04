package Arkess::Component::CameraFollow;

use strict;
use Arkess::Direction;
use Arkess::Component::Mobile;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $background, $followType) = @_; # TODO: Export follow types

  die "Must specify background" unless $background;
  my $component = Arkess::Component::Mobile->new();
  $component->install($background); # need to install component directly since extend will only give a copy
  $followType ||= 'scroll'; # when the followed character becomes out of bounds, transition the whole screen
  $self->{background} = $background;
  $self->{followType} = $followType;
}

sub setPriority {
  return 1;
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $background = $self->{background};
  $cob->on('move', sub {
    my ($x, $y) = $cob->getCoordinates();
    my ($bx, $by) = $background->getCoordinates();
    my ($bwidth, $bheight) = $background->getDimensions();

    if ($x > $bwidth-1) {
      $background->move(Arkess::Direction::LEFT, $bwidth);
      $cob->setX(0);
    }
    elsif ($y > $bheight-1) {
      $background->move(Arkess::Direction::UP, $bheight);
      $cob->setY(0);
    }
    elsif ($x < 0) {
      $background->move(Arkess::Direction::RIGHT, $bwidth);
      $cob->setX($bwidth-1);
    }
    elsif ($y < 0) {
      $background->move(Arkess::Direction::DOWN, $bheight);
      $cob->setY($bheight-1);
    }
  });
}

1;
__END__
=head1 NAME
Arkess::Component::CameraFollow - Keep a mobile entity in the center of the
screen
