package Arkess::IO::Terminal::Command::Builtin::LoadPlugin;

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub registersAs {
  return 'load-plugin';
}

sub execute {
  my ($self, $plugin) = @_;

  $self->_getShell()->loadPlugin($plugin);
  return 1;
}

1;
