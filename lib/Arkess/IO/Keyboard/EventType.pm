package Arkess::IO::Keyboard::EventType;

use strict;
use SDL::Events;
use base qw(Exporter);

use constant HOLD     => 'keyHold';
use constant KEY_UP   => SDL_KEYUP;
use constant KEY_DOWN => SDL_KEYDOWN;

our @EXPORT = qw(HOLD KEY_UP KEY_DOWN);

1;
