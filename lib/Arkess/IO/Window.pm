package Arkess::IO::Window;
#
# Window events
use strict;
use SDL::Events;
use base qw(Exporter);

our @EXPORT = qw(
  WIN_QUIT
);

use constant WIN_QUIT => SDL_QUIT;

1;
