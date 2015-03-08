package Arkess::Component::InventoryHolder;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $maxItems) = @_;

  $self->{max} = $maxItems;
  $self->{inventory} = [];
}

sub exportMethods {
  my $self = shift;

  return {

    addToInventory => sub  {
      my ($cob, $item) = @_;

      return 0 if (defined $self->{max} && scalar(@{$self->{inventory}}) > $self->{max});
      push(@{$self->{inventory}}, $item);
      return 1;
    },

    hasInInventory => sub {
      my ($cob, $name) = @_;

      # TODO
    },

    listInventory => sub {
      return @{$self->{inventory}};
    },

    removeFromInventory => sub {
      my ($cob, $item) = @_;

      my $index = 0;
      foreach my $contained (@{$self->{inventory}}) {
        if ($contained eq $item) {
          return splice(@{$self->{inventory}}, $index, 1);
        }
        $index++;
      }
    },

    clearInventory => sub {
      $self->{inventory} = []
    }
  };
}

1;
