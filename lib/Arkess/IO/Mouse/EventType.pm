package Arkess::IO::Mouse::EventType;

use strict;
use SDL::Events;
use base qw(Exporter);

# Map constants to their SDL equivalents

use constant BTN_HOLD => 'btnHold';
use constant BTN_UP   => SDL_MOUSEBUTTONUP;
use constant BTN_DOWN => SDL_MOUSEBUTTONDOWN;
use constant MOVE     => SDL_MOUSEMOTION;

print "BTN_DOWN: " . SDL_MOUSEBUTTONDOWN . "\n";
print "BTN_UP: " . SDL_MOUSEBUTTONUP . "\n";
our @EXPORT = qw(BTN_HOLD BTN_UP BTN_DOWN MOVE);

1;
