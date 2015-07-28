package Arkess::Component::Debug;

use strict;
use Digest::MD5 qw(md5);
use base qw(Arkess::Component);

our $DEBUG_SYMBOL = 0;

sub initialize {
  my ($self, $active) = @_;

  $self->{active} = defined $active ? $active : 1; # on by default
}

sub afterInstall {
  my ($self, $cob) = @_;

  $DEBUG_SYMBOL++;
  $cob->_debug();
}

sub exportMethods {
  my $self = shift;

  return {

    # Make it easier to keep track of objects
    getDebugSymbol => sub {
      my $cob = shift;

      return 'COB' . $DEBUG_SYMBOL;
    },

    printDebugSymbol => sub {
      my $cob = shift;

      print $cob->getDebugSymbol() . "\n";
    },

    # Convert the components the cob has installed into a hash for fingerprinting
    fingerprintComponents => sub {
      my $cob = shift;

      my @components = $cob->components;
      my @sorted = sort {$a cmp $b} @components;
      my $componentString = join(' ', @sorted);
      return unpack('L', md5($componentString));
    },

    getComponentList => sub {
      my $cob = shift;

      return $cob->components;
    },

    getNumberOfComponents => sub {
      my $cob = shift;

      my @components = $cob->getComponentList();
      return scalar(@components);
    },

    _debug => sub {
      my $cob = shift;

      print $cob->getDebugSymbol() . "($cob): " . $cob->fingerprintComponents() . "_FP (" . $cob->getNumberOfComponents() . " installed)\n";
    }

  };
}

1;
