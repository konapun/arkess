#!/usr/bin/perl

use strict;
use Curses::UI;

my $cui = new Curses::UI( -color_support => 1 );
my @menu = ({
  -label => 'File',
  -submenu => [{
    -label => 'Exit      ^Q',
    -value => \&exit_dialog
  }]
});
my $menu = $cui->add('menu','Menubar',
  -menu => \@menu,
  -fg  => "blue",
);
$cui->mainloop();
