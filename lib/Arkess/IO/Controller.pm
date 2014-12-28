package Arkess::IO::Controller;

use strict;

sub new {
  my $package = shift;
  my ($character, $bindings) = @_;

  return bless {
    character => $character,
    bindings  => $bindings || {}
  }, $package;
}

sub setPlayer {
  my ($self, $player) = @_;

  shift->{character} = $player;
}

sub getPlayer {
  return shift->{character};
}

sub hold {
  my ($self, $key, $sub) = @_;

  return $self->bind($key, $sub);
}

sub press {
  my ($self, $key, $sub) = @_;

  if (ref $key eq 'HASH') { # Bind multiple as a hash
    while (my ($k, $s) = each %{$key}) {
      $self->bind($k, $s)
    }
  }
  else {
    $self->{bindings}->{$key} = $sub;
  }
}

sub bind { # FIXME: HOLD
  my ($self, $key, $sub) = @_;

  return $self->press($key, $sub);
}

sub process {
  my ($self, $event) = @_;

  return if $self->_processKeypress($event);
  return $self->_processType($event);
}

sub _processKeypress {
  my ($self, $event) = @_;

  my $key = $event->key_sym;
  my $cb = $self->{bindings}->{$key};
  if (defined $cb) {
    return $cb->($self->{character});
  }
  return undef;
}

sub _processType {
  my ($self, $event) = @_;

  my $type = $event->type;
  my $cb = $self->{bindings}->{$type};
  if (defined $cb) {
    return $cb->($self->{character});
  }
  return undef;
}

1;
