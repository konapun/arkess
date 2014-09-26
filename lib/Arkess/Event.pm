package Arkess::Event;

use strict;

use constant {
  BEFORE_RENDER  => 0,
  AFTER_RENDER   => 1,
  LOOP_START     => 2,
  RUNTIME_START  => 3,
  RUNTIME_STOP   => 4,
};

1;

__END__
=head1 NAME
Arkess::Event - An enumeration of all standard events fired by the Arkess
Runtime
