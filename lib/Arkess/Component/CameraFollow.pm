package Arkess::Component::CameraFollow;

use strict;
use Arkess::Direction;
use Arkess::Component::Mobile;
use base qw(Arkess::Component);

# Export follow types
use constant SCROLL => 'scroll'; # when the player reaches screen bounds, transition to new screen
use constant CENTER => 'center'; # keep player centered in the screen when possible
use constant SHOOTER => 'shooter';

sub requires {
  return [
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable',
    'Arkess::Component::Positioned', # Absolute (x, y) coordinates in terms of game positions
    'Arkess::Component::Renderable' # (x, y) coordinates relative to the screen
  ];
}

sub initialize {
  my ($self, $background, $followType) = @_; # TODO: Export follow types

  die "Must specify background" unless $background; # TODO: locate background automatically by looking through runtime's entities?
  my $component = Arkess::Component::Mobile->new();
  $background->installComponent($component); # need to install component directly since extend will only give a copy
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
  elsif ($transition eq 'shooter') {
    $self->_setupShooterTransitions($cob, $background);
  }
  else {
    die "Unknown transition type '$transition'";
  }
}

sub _setupScrollTransitions {
  my ($self, $cob, $background) = @_;

  $cob->on('move', sub {
    my ($x, $y) = $cob->getCoordinates();
    my ($width, $height) = $cob->getDimensions();
    my ($bwidth, $bheight) = $background->getDimensions();
    my ($bwidthFull, $bheightFull) = $background->getImageDimensions();
    my ($bx, $by) = $background->getCoordinates();

    if ($bx >= 0 && $x <= 0) { # Keep entity from going out of bounds left
      $cob->setX(0);
    }
    elsif ($bx <= ($bwidthFull-$bwidth)*-1 && $x >= $bwidth) { # Keep entity from going out of bounds right
      $cob->setScreenX($bwidth-1);
    }
    elsif ($x < 0 && $bx <= 0) { # Transition for cob moving left off of screen
      $background->move(Arkess::Direction::RIGHT, $bwidth);
      $cob->setScreenX($bwidth-1);
    }
    elsif ($x > $bwidth-1) { # Transition for cob moving right off of screen
      $background->move(Arkess::Direction::LEFT, $bwidth);
      $cob->setX(0);
    }

    if ($by >= 0 && $y <= 0) { # Keep entity from going out of bounds top
      $cob->setY(0);
    }
    elsif ($by <= ($bheightFull-$bheight)*-1 && $y >= $bheight) { # Keep entity from going out of bounds bottom
      $cob->setY($bheight-1);
    }
    elsif ($y < 0 && $by <= 0) { # Transition for cob moving up off of screen
      $background->move(Arkess::Direction::DOWN, $bheight);
      $cob->setScreenY($bheight-1);
    }
    elsif ($y > $bheight-1) { # Transition for cob moving down off of screen
      $background->move(Arkess::Direction::UP, $bheight);
      $cob->setScreenY(0);
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

sub _setupShooterTransitions {
  my ($self, $cob, $background) = @_;

  $cob->on('move', sub {
    my ($x, $y) = $cob->getCoordinates();
    my ($bwidth, $bheight) = $background->getDimensions();
    my ($bwidthFull, $heightFull) = $background->getImageDimensions();
    my ($bx, $by) = $background->getCoordinates();

    if ($bx >= 0 && $x <= 0) {
      $cob->setX(0);
    }
    elsif ($x < 0 && $bx <= 0) {
      $background->move(Arkess::Direction::RIGHT, $bwidth);
      $cob->setX($bwidth-1);
    }
    elsif ($x > $bwidth-1) {
      $background->move(Arkess::Direction::LEFT, $bwidth);
      $cob->setX(0);
    }

    if ($by >= 0 && $y <= 0) {
      $cob->setY(0);
    }
    elsif ($y < 0 && $by <= 0) {
print "MOVING BG DOWN\n";
      $background->move(Arkess::Direction::DOWN, $bheight);
      $cob->setY($bheight-1);
    }

    elsif ($y > $bheight-1) {
print "MOVING BG UP\n";
      $background->move(Arkess::Direction::UP, $bheight);
      $cob->setY(0);
    }
  });
}

1;
__END__
=head1 NAME
Arkess::Component::CameraFollow - Keep a mobile entity in the center of the
screen
