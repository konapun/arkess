package Arkess::IO::Window::EventType;

use strict;
use SDL::Events;
use base qw(Exporter);

# Map constants to their SDL equivalents

use constant QUIT     => SDL_QUIT;
use constant RESIZE   => SDL_VIDEORESIZE;
use constant EXPOSE   => SDL_VIDEOEXPOSE;

our @EXPORT = qw(QUIT RESIZE EXPOSE);

1;
