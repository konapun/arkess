package Arkess::IO::Mouse::EventType;

use strict;
use SDL::Events;
use base qw(Exporter);

# Map constants to their SDL equivalents

use constant BTN_HOLD => 'btnHold';
use constant BTN_UP   => SDL_MOUSEBUTTONDOWN;
use constant BTN_DOWN => SDL_MOUSEBUTTONUP;
use constant MOVE     => SDL_MOUSEMOTION;

our @EXPORT = qw(BTN_HOLD BTN_UP BTN_DOWN MOVE);

1;
