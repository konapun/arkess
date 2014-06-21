package Arkess::IO::Controller;

use strict;

sub new {
  my $package = shift;
  my $character = shift;

  return bless {
    character => $character,
    bindings  => {}
  }, $package;
}

sub bind {
  my ($self, $key, $sub) = @_;

  $self->{bindings}->{$key} = $sub;
}

sub process {
  my ($self, $key) = @_;

  if (!defined $key) { # wait for keypress
    # TODO
  }

  my $cb = $self->{bindings}->{$key};
  if (defined $cb) {
    return $cb->($self->{character});
  }
}

1;
