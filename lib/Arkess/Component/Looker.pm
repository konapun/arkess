
package Arkess::Component::Looker;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::EntityPositioned' # need to be positioned on a tile
  ];
}

sub exportMethods {
  return {

    look => sub {
      my $cob = shift;

      my $tile = $cob->getPosition();
      if ($tile && $tile->hasAttribute('describable')) {
        print "You are in " . $tile->getDescription() . "\n"; # Current location

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

        print "To the north you see " . $tile->getLink(UP)->getDescription() . "\n" if ($tile->hasLink(UP));
        print "To the west you see " . $tile->getLink(LEFT)->getDescription() . "\n" if ($tile->hasLink(LEFT));
        print "To the east you see " . $tile->getLink(RIGHT)->getDescription() . "\n" if ($tile->hasLink(RIGHT));
        print "To the south you see " . $tile->getLink(DOWN)->getDescription() . "\n" if ($tile->hasLink(DOWN));
      }
    }
  }
}

1;

__END__
=head1 NAME
Arkess::Component::Looker - Component for a Cob that can examine descriptions