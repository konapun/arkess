package Arkess::Component::Destroyable;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::RuntimeAware',
    'Arkess::Component::Observable'
  ];
}

sub exportMethods {

  return {

    destroy => sub {
      my $cob = shift;

      my $status = 0;
      if ($cob->hasRuntime()) {
        my $runtime = $cob->getRuntime();
        $status = $runtime->removeEntity($cob);
      }
      # TODO: Also need to remove any associated controllers
      $cob = undef;
      return $status;
    }

  }
}

1;

__END__
=head1 NAME
Arkess::Component::Destroyable - Attempt to unregister an object with the
runtime and destroy all refs to it (not guaranteed)
