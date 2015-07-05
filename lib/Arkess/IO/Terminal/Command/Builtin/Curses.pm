package Arkess::IO::Terminal::Command::Builtin::Curses;

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub registersAs {
  return 'curses';
}

sub execute {
  my $self = shift;
  
  my $shell = $self->{shell};
  print "NOT IMPLEMENTED\n";
  return 1;
}

sub getDescription {
  return "Activates the ncurses module";
}

1;
