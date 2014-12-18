package Arkess::Component::Renderable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable',
  ];
}

sub exportAttributes {
  return {
    renderable => 1, # needed in order to be picked up by the rendering engine
    screenX    => 0,
    screenY    => 0,
    width      => 160, #FIXME
    height     => 160,
    renderer   => undef # set by the rendering engine
  };
}

sub exportMethods {
  return {

    setRenderer => sub {
      my ($cob, $renderer) = @_;

      return $cob->set('renderer', $renderer);
    },

    setScreenCoordinates => sub {
      my ($cob, $x, $y) = @_;

      $cob->set('screenX', $x);
      $cob->set('screenY', $y);
    },

    getScreenCoordinates => sub {
      my $cob = shift;

#      print "Returning coords (" . $cob->get('screenX') . ", " . $cob->get('screenY') . ")\n";
      return ($cob->get('screenX'), $cob->get('screenY'));
    },

    setDimensions => sub {
      my ($cob, $width, $height) = @_;

      $cob->set('width', $width);
      $cob->set('height', $height);
    },

    getDimensions => sub {
      my $cob = shift;

      return ($cob->get('width'), $cob->get('height'));
    },

    getRenderer => sub {
      return shift->get('renderer');
    },

    render => sub {
      # pass - not implemented here
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Renderable - A component required by any entity which draws
to the screen
