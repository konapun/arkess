package Arkess::IO::Terminal::Command::Builtin::LoadPlugin;

use strict;

sub new {
  my $package = shift;
  my $shell = shift;

  return bless {
    shell => $shell,
  }, $package;
}

sub registersAs {
  return 'load-plugin';
}

sub execute {
  my ($self, $plugin) = @_;

  $self->{shell}->loadPlugin($plugin);
  return 1;
}

1;
