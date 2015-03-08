
package Arkess::Component::Looker;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityPositioned' # need to be positioned on a tile
  ];
}

sub initialize {
  my ($self, $useCompassDirections) = @_;

  $self->{compass} = defined $useCompassDirections ? $useCompassDirections : 0; # Report directions as up, down, etc. rather than north, south by default
}

sub exportMethods {
  return {

    look => sub {
      my $cob = shift;

      my $tile = $cob->getPosition();
      if ($tile && $tile->hasAttribute('describable')) {
        print "You are in " . lcfirst $tile->getDescription() . "\n"; # Current location

        my $printedHeader = 0;
        my $entities = $tile->getEntities();
        if (scalar(@$entities) > 0) {
          foreach my $entity (@$entities) {
            if ($entity->hasAttribute('describable')) {
              if (!$printedHeader) {
                print "You see:\n";
                $printedHeader = 1;
              }

              print "\t" . $entity->getName() . "\n";
            }
          }
        }

        my $north = $tile->getLink(UP);
        my $west = $tile->getLink(LEFT);
        my $east = $tile->getLink(RIGHT);
        my $south = $tile->getLink(DOWN);

        my $northDescription = lcfirst($north->getShortDescription() || $north->getDescription()) if defined $north;
        my $westDescription = lcfirst($west->getShortDescription() || $west->getDescription()) if defined $west;
        my $eastDescription = lcfirst($east->getShortDescription() || $east->getDescription()) if defined $east;
        my $southDescription = lcfirst($south->getShortDescription() || $south->getDescription()) if defined $south;

        print "To the north you see $northDescription\n" if ($tile->hasLink(UP));
        print "To the west you see $westDescription\n" if ($tile->hasLink(LEFT));
        print "To the east you see $eastDescription\n" if ($tile->hasLink(RIGHT));
        print "To the south you see $southDescription\n" if ($tile->hasLink(DOWN));
      }
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Looker - Component for a Cob that can examine descriptions
