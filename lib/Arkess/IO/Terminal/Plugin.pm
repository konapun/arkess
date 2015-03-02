package Arkess::IO::Terminal::Plugin;

use strict;

sub new {
  return bless {}, shift;
}

sub register {
  my ($self, $terminal) = @_;

  die "Plugin must provide an implementation for method 'register'";
}

1;
