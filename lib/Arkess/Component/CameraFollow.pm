package Arkess::Component::CameraFollow;

use strict;
use Arkess::Direction;
use Arkess::Component::Mobile;
use base qw(Arkess::Component);

# Export follow types
use constant SCROLL => 'scroll'; # when the player reaches screen bounds, transition to new screen
use constant CENTER => 'center'; # keep player centered in the screen when possible

sub requires {
  return [
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $background, $followType) = @_; # TODO: Export follow types

  die "Must specify background" unless $background; # TODO: locate background automatically by looking through runtime's components?
  my $component = Arkess::Component::Mobile->new();
  $component->install($background); # need to install component directly since extend will only give a copy
  $followType ||= 'scroll'; # when the followed character becomes out of bounds, transition the whole screen
  $self->{background} = $background;
  $self->{transition} = $followType;
}

sub setPriority {
  return 1;
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $transition = $self->{transition};
  my $background = $self->{background};
  if ($transition eq 'scroll') {
    $self->_setupScrollTransitions($cob, $background);
  }
  elsif ($transition eq 'center') {
    $self->_setupCenterTransitions($cob, $background);
  }
  elsif ($transition eq 'pause slide') {
    $self->_setupPauseSlide($cob, $background);
  }
  else {
    die "Unknown transition type '$transition'";
  }
}

sub _setupScrollTransitions {
  my ($self, $cob, $background) = @_;

  $cob->on('move', sub {
    my ($x, $y) = $cob->getCoordinates();
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

sub _setupCenterTransitions {
  my ($self, $cob, $background) = @_;

  my ($bwidthFull, $bheightFull) = $background->getDimensions();
  $cob->on('move', sub {
    my ($direction, $units) = @_;

    my ($x, $y) = $cob->getCoordinates();
    my ($bx, $by) = $background->getCoordinates();
    my ($bwidth, $bheight) = $background->getDimensions();
    if ((abs($bx) <= 0 && $x < $bwidth/2) || (abs($by) <= 0 && $y < $bheight/2) || (abs($bx) > $bwidthFull && $x >= $bwidth/2) || (abs($by) >= $bheightFull && $y >= $bheight/2)) {
      # pass for now
    }
    else {
      $cob->setCoordinates($bwidth/2, $bheight/2);
      $background->move(Arkess::Direction::reverse($direction), $units);
    }
  });
}

1;
__END__
=head1 NAME
Arkess::Component::CameraFollow - Keep a mobile entity in the center of the
screen
