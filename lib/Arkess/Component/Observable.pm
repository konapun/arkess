package Arkess::Component::Observable;

use strict;
use base qw(Cobsy::Component);

sub afterInstall {
  my ($self, $owner) = @_;

  # Need to make sure this doesn't alter the "base" object...
  $owner->methods->each(sub {
    my ($key, $val) = @_;

    return if $key eq 'trigger' || $key eq 'on';
    $owner->methods->set($key, sub {
      my ($cob, @args) = @_;

      my $return = $val->call(@args);
      $owner->trigger($key, $return);
      return $return;
    });
  });
}

sub exportAttributes {
  return {
    events => {}
  };
}

sub exportMethods {
  my $self = shift;

  return {
    on => sub {
      my ($cob, $event, $callback) = @_;

      $self->{events}->{$event} = [] unless defined $self->{events}->{$event};
      push(@{$self->{events}->{$event}}, $callback);
      return $callback; # so it can be used to unregister (more on this later)
    },
    trigger => sub {
      my ($cob, $event, @args) = @_;

      return unless defined $self->{events}->{$event};
      foreach my $cb (@{$self->{events}->{$event}}) {
        $cb->(@args);
      }
    }
  };
}

1;
