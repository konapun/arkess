package Arkess::IO::Keyboard;
#
# An abstraction for the keyboard
# See full list here: http://falconpl.org/project_docs/sdl/class_SDLK.html
#
#TODO: Optionally export all symbols (:all)

use strict;
use SDL::Events;
use base qw(Exporter);

# Automatically export all symbols
our @EXPORT = qw(
	KB_RETURN
	KB_SPACE
	KB_0
	KB_1
	KB_2
	KB_3
	KB_4
	KB_5
	KB_6
	KB_7
	KB_8
	KB_9
	KB_W
	KB_A
	KB_S
	KB_D
	KB_UP
	KB_DOWN
	KB_LEFT
	KB_RIGHT
	KB_RSHIFT
	KB_LSHIFT
	KB_RCTRL
	KB_LCTRL
	KB_RALT
	KB_LALT
	KB_RMETA
	KB_LMETA
	KB_RSUPER
	KB_LSUPER
);
our %EXPORT_TAGS = ('all' => \@EXPORT);

use constant KB_RETURN => SDLK_RETURN;
use constant KB_SPACE  => SDLK_SPACE;
use constant KB_0      => SDLK_0;
use constant KB_1      => SDLK_1;
use constant KB_2      => SDLK_2;
use constant KB_3      => SDLK_3;
use constant KB_4      => SDLK_4;
use constant KB_5      => SDLK_5;
use constant KB_6      => SDLK_6;
use constant KB_7      => SDLK_7;
use constant KB_8      => SDLK_8;
use constant KB_9      => SDLK_9;
use constant KB_W      => SDLK_w;
use constant KB_A      => SDLK_a;
use constant KB_S      => SDLK_s;
use constant KB_D      => SDLK_d;
use constant KB_UP     => SDLK_UP;
use constant KB_DOWN   => SDLK_DOWN;
use constant KB_LEFT   => SDLK_LEFT;
use constant KB_RIGHT  => SDLK_RIGHT;

# Modifiers
use constant KB_RSHIFT => SDLK_RSHIFT;
use constant KB_LSHIFT => SDLK_LSHIFT;
use constant KB_RCTRL  => SDLK_RCTRL;
use constant KB_LCTRL  => SDLK_LCTRL;
use constant KB_RALT   => SDLK_RALT;
use constant KB_LALT   => SDLK_LALT;
use constant KB_RMETA  => SDLK_RMETA;
use constant KB_LMETA  => SDLK_LMETA;
use constant KB_RSUPER => SDLK_RSUPER;
use constant KB_LSUPER => SDLK_LSUPER;

#TODO

1;
