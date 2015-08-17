package Arkess::IO::Mouse;
#
# An abstraction for the mouse
# More here: http://sdl.perl.org/SDL-Events.html

use strict;
use SDL::Events;
use SDL::Mouse;
use base qw(Exporter);

our @EXPORT = qw(
  MOUSE_LCLICK
  MOUSE_RCLICK
  MOUSE_MCLICK
  MOUSE_SCROLLUP
  MOUSE_SCROLLDOWN
);

# Click events
use constant MOUSE_LCLICK => SDL_BUTTON_LEFT;
use constant MOUSE_RCLICK => SDL_BUTTON_RIGHT;
use constant MOUSE_MCLICK => SDL_BUTTON_MIDDLE;

# Scroll events
use constant MOUSE_SCROLLUP   => SDL_BUTTON_WHEELUP;
use constant MOUSE_SCROLLDOWN => SDL_BUTTON_WHEELDOWN;

sub show_cursor {
  SDL::Mouse::show_cursor(SDL_ENABLE);
}

sub hide_cursor {
  SDL::Mouse::show_cursor(SDL_DISABLE);
}

1;
