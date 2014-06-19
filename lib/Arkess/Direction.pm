package Arkess::Direction;

use strict;
use base qw(Exporter);

use constant UP    => 'up';
use constant DOWN  => 'down';
use constant LEFT  => 'left';
use constant RIGHT => 'right';

our @EXPORT = qw(UP DOWN LEFT RIGHT);

1;

__END__
=head1 NAME
Arkess::Direction - Auto-exported directions enum for Arkess
