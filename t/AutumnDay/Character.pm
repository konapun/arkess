package AutumnDay::Character;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Looker',
    'Arkess::Component::Named',
    'Arkess::Component::EntityPositioned',
    'Arkess::Component::Actioned',
    'Arkess::Component::InventoryHolder',
    'Arkess::Component::Mortal'
  ];
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->addAction('move', sub {
    return $cob->move(@_);
  });
  $cob->addAction('look', sub {
    return $cob->look(@_);
  });
  $cob->addAction('take', sub {
    my $object = lc shift;

    my $tile = $cob->getPosition();
    my @items = $tile->listEntities();
    foreach my $item (@items) {
      if ($item->hasMethod('getName')) {
        if ($object eq lc($item->getName())) {
          $tile->removeEntity($item);
          $cob->addToInventory($item);
        }
      }
    }
  });
  $cob->addAction('inventory', sub {
    print "Inventory\n";
    print "---------\n";
    foreach my $item ($cob->listInventory()) {
      print "\t" . $item->getName() . "\n";
    }
  });
  $cob->addAction('examine', sub {
    my $object = lc shift;

    foreach my $item ($cob->listInventory()) { # First, examine inventory
      if (lc $item->getName() eq $object) {
        print $item->getDescription() . "\n";
        return;
      }
    }

    my $tile = $cob->getPosition();
    foreach my $entity ($tile->listEntities()) {
      if (lc $entity->getName() eq $object) {
        print $entity->getDescription() . "\n";
        return;
      }
    }

    print "Can't locate object '$object'\n";
  });
  $cob->addAction('drop', sub {
    my $object = lc shift;

    foreach my $item ($cob->listInventory()) {
      if (lc $item->getName() eq $object) {
        my $tile = $cob->getPosition();
        $cob->removeFromInventory($item);
        $tile->addEntity($item);
        return 1;
      }
    }
    print "Can't locate item '$object' in inventory\n";
  });
  $cob->addAction('proxy', sub { # Allow calling actions on items in inventory through player
    my ($action, $object) = @_;

    foreach my $item ($cob->listInventory()) {
      if (lc $item->getName() eq $object) {
        if ($item->hasAttribute('actioned')) {
          $item->callAction($action);
          return 1;
        }
      }
    }
    print "Couldn't locate actioned item for proxy\n";
  });
}
1;