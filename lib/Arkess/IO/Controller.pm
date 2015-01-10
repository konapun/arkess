package Arkess::IO::Controller;

use strict;
use Arkess::IO::Keyboard::EventType;

sub new {
  my $package = shift;
  my ($character, $bindings) = @_;

  my $self = bless {
    character => $character,
    bindings  => {
      # assigned as-needed from EventType
    }
  }, $package;

  $self->bind($bindings) if defined $bindings;
  return $self;
}

sub setPlayer {
  my ($self, $player) = @_;

  shift->{character} = $player;
}

sub getPlayer {
  return shift->{character};
}

sub bind {
  my ($self, $key, $type, $sub) = @_;

  return $self->_bindHash($key, $type) if ref $key eq 'HASH';
  if (!defined $sub) { # No key was provided, probably a window event (leave off key)
    my $tmp = $type;
    $type = $key;
    $sub = $tmp;

    $self->{bindings}->{$type} = $sub
  }
  else {
    $self->{bindings}->{$type} = {} unless defined $self->{bindings}->{$type};
    $self->{bindings}->{$type}->{$key} = $sub;
  }
}

sub process {
  my ($self, $event) = @_; # An SDL event

  my $type = $event->type();
  if (defined $self->{bindings}->{$type}) {
    # First, check for events which fire without a keysym
    my $action = $self->{bindings}->{$type};
    return $action->($self->{character}) if ref $action eq 'CODE';

    # Events which fire with a keysym
    my $sym = $event->key_sym();
    $action = $self->{bindings}->{$type}->{$sym};
    return $action->($self->{character}) if defined $action;
  }
}

sub _bindHash {
  my ($self, $hash, $eventType) = @_;

  my $type = Arkess::IO::Keyboard::EventType::KEY_DOWN unless defined $eventType;
  while (my ($key, $sub) = each %{$hash}) {
    $self->bind($key, $type, $sub);
  }
}

1;
