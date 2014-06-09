package Arkess::Direction;

use strict;
use base qw(Exporter);

use constant UP    => 0;
use constant DOWN  => 1;
use constant LEFT  => 2;
use constant RIGHT => 3;

our @EXPORT = qw(UP DOWN RIGHT LEFT);

1;

__END__
=head1 NAME
Arkess::Direction - Auto-exported directions enum for Arkess
