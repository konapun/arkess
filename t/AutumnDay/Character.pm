package AutumnDay::Character;

use strict;
use Arkess::Direction;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Looker',
    'Arkess::Component::Named',
    'Arkess::Component::EntityPositioned',
    'Arkess::Component::Actioned',
    'Arkess::Component::InventoryHolder',
    'Arkess::Component::Mortal',
    'Arkess::Component::Conversable',
#    'AutumnDay::Character::Component::HungerMove'
  ];
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $coordSystem = 'abs';
  $cob->addAction('move', sub {
    my ($self, @args) = @_;
    my $status = $cob->move(@args);
    $cob->look(1);
    return $status;
  });
  $cob->addAction('look', sub {
    return $cob->look();
  });
  $cob->addAction('fps-coords', sub {
    $coordSystem = 'fps';
  });
  $cob->addAction('abs-coords', sub {
    $coordSystem = 'abs';
  });
  $cob->addAction('w', sub {
    return $cob->callAction('move', UP);
  });
  $cob->addAction('a', sub {
    return $cob->callAction('move', LEFT);
  });
  $cob->addAction('s', sub {
    return $cob->callAction('move', DOWN);
  });
  $cob->addAction('d', sub {
    return $cob->callAction('move', RIGHT);
  });
  $cob->addAction('take', sub {
    my ($self, $object) = @_;

    my $found = $cob->callAction('_find', $object);
    if ($found) {
      my $location = $found->getPosition();
      $location->removeEntity($found);
      $cob->addToInventory($found);
    }

    # my @items = $tile->listEntities();
    # foreach my $item (@items) {
    #   if ($item->hasMethod('getName')) {
    #     if ($object eq lc($item->getName())) {
    #       $tile->removeEntity($item);
    #       $cob->addToInventory($item);
    #     }
    #   }
    # }
  });
  $cob->addAction('inventory', sub {
    print "Inventory\n";
    print "---------\n";
    foreach my $item ($cob->listInventory()) {
      print "\t" . $item->getName() . "\n";
    }
  });
  $cob->addAction('examine', sub {
    my ($self, $object) = @_;

    my $found = $cob->callAction('_find', $object);
    if ($found && $found->hasAttribute('describable')) {
      print $found->getDescription() . "\n";
      if ($found->hasAttribute('attributed')) {
        print "The following states are set on $object:\n";
        $found->eachAttribute(sub {
          my ($key, $val) = @_;

          print "\t$key: $val\n";
        });
      }
      if ($found->hasAttribute('holdsEntities')) {
        my @entities = $found->listEntitiesExcept($cob);
        return unless @entities;
        print "Peering at the $object you see the following:\n";
        foreach my $entity (@entities) {
          print "\t" . $entity->getName() . "\n" if $entity->hasAttribute('named') && $entity ne $cob;
        }
      }

      return;
    }

    print "Can't locate object '$object'\n";
  });
  $cob->addAction('drop', sub {
    my ($self, $object) = @_;
    $object = lc $object;

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
  $cob->addAction('put', sub {
    my ($self, $needle, $haystack) = @_;
    $needle = lc $needle;
    $haystack = lc $haystack;

    my $needleObj;
    foreach my $item ($cob->listInventory()) {
      if (lc $item->getName() eq $needle) {
        $cob->removeFromInventory($item);
        $needleObj = $item;
        last;
      }
    }
    if (defined $needleObj) { # now find place to put it
      my $tile = $cob->getPosition();
      foreach my $item ($tile->listEntitiesWithAttribute('holdsEntities')) {
        if (lc $item->getName() eq $haystack) {
          $item->addEntity($needleObj);
          return 1;
        }
      }
      print "Can't locate '$haystack'\n";
    }
    else {
      print "Can't locate item '$needle' in inventory\n";
    }
  });
  $cob->addAction('proxy', sub { # Allow calling actions on items in inventory through player
    my ($self, $action, $object) = @_;

    my $found = $cob->callAction('_find', $object);
    if ($found && $found->hasAttribute('actioned')) {
      $found->callAction($action);
      return 1;
    }
    print "Couldn't locate actioned item for proxy\n";
  });
  $cob->addAction('talk', sub {
    my ($self, $blank, $object) = @_;

    my $found = $cob->callAction('_find', $object);
    if ($found) {
      if ($found->hasAttribute('conversable')) {
        $found->talkTo($cob->getName());
      }
      else {
        print "$object doesn't say anything\n";
      }
    }
    else {
      print "Can't locate object '$object'\n";
    }
  });
  $cob->addAction('status', sub {
    print "Name: " . $cob->getName() . "\n";
    print "Health: " . $cob->getHP() . "\n";
  });
  $cob->addAction('_find', sub { # Locate an object based on name
    my ($self, $object) = @_;
    $object = lc $object;

    my $tile = $cob->getPosition();
    foreach my $item ($cob->listInventory()) { # First, check inventory
      return $item if (lc $item->getName() eq $object);
    }
    foreach my $entity ($tile->listEntitiesExcept($cob)) { # Second, check entities contained in tile
      return $entity if $entity->hasAttribute('named') && lc $entity->getName() eq $object;
      if ($entity->hasAttribute('holdsEntities')) { # Also check for nested entities (TODO: recurse)
        foreach my $contained ($entity->listEntities()) {
          return $contained if $contained->hasAttribute('named') && lc $contained->getName() eq $object;
        }
      }
    }

    return $tile if ($tile->hasAttribute('named') && lc $tile->getName() eq $object);# Last, check the tile itself
  });

  # Events
  $cob->on('move', sub {
    print "MOVING!\n";
  });
}

1;
