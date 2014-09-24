package Arkess::Component::Mobile;

use strict;
#use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $tile, $direction) = @_;

  $direction = 'down' unless defined $direction;
  $self->{tile} = $tile;
  $self->{direction} = $direction;
}

sub exportAttributes {
  my $self = shift;

  return {
    position => {
      tile      => $self->{tile},
      direction => $self->{direction}
    }
  };
}

sub exportMethods {

  # TODO: Also use addEntity/removeEntity for tiles
  return {

    getPosition => sub {
      my $cob = shift;

      return $cob->get('position');
    },

    getTile => sub {
      my $cob = shift;

      my $position = $cob->getPosition();
      return $position->{tile};
    },

    getDirection => sub {
      my $cob = shift;

      my $position = $cob->getPosition();
      return $position->{direction};
    },

    setPosition => sub {
      my ($cob, $tile, $direction) = @_;

      $direction = 'down' unless defined $direction;
      $cob->set('position', {
        tile      => $tile,
        direction => $direction
      });
    },

    setTile => sub {
      my ($cob, $tile) = @_;

      $cob->setPosition($tile);
    },

    setDirection => sub {
      my ($cob, $direction) = @_;

      my $tile = $cob->getTile();
      $cob->setPosition($tile, $direction);
    },

    # Move without changing direction
    # Return true or false depending on whether or not the cob was able to move
    strafe => sub {
      my ($cob, $direction, $facing) = @_;

      my $position = $cob->getPosition();
      my $tile = $position->{tile};
      $facing = $position->{direction} unless defined $facing;
      return 0 if $tile eq undef; # Cob not positioned
      my $newTile = $tile->getLink($direction);
      return 0 unless $newTile; # No link to tile in direction
      $cob->setPosition($newTile, $facing);
      $cob->trigger('strafe', [$direction, $facing]);
      return 1;
    },

    # Move while changing position
    move => sub {
      my ($cob, $direction) = @_;

      my $success = $cob->strafe($direction, $direction);
      $cob->trigger('move', [$direction]) if $success;
      return $success;
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Mobile - A component for objects that can move around
