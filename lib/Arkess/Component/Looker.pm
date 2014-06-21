package Arkess::Component::Looker;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Mobile' # need to be positioned on a tile
  ];
}

sub exportMethods {
  return {
    'look' => sub {
      my $cob = shift;

      my $tile = $cob->getTile();
      if ($tile) {
        if ($tile->hasAttribute('description')) {
          print "You are in " . $tile->getDescription() . "\n"; # Current location

          my @entities = $tile->getEntities();
          if (scalar(@entities) > 0) {
            print "You see:\n";
            foreach my $entity (@entities) {
              print "\t" . $entity->getDescription() . "\n"; # if $entity->hasAttribute('description');
            }
          }

          if ($tile->hasLink(UP)) {
            my $link = tile->getLink(UP);

            print "To the north you see " . $link->getDescription() . "\n";
          }
          if ($tile->hasLink(LEFT)) {
            my $link = $tile->getLink(LEFT);

            print "To the west you see " . $link->getDescription() . "\n";
          }
          if ($tile->hasLink(RIGHT)) {
            my $link = $tile->getLink(RIGHT);

            print "To the east you see " . $link->getDescription() . "\n";
          }
          if ($tile->hasLink(DOWN)) {
            my $link = $tile->getLink(DOWN);

            print "To the south you see " . $link->getDescription() . "\n";
          }
        }
      }
    }
  }
}
