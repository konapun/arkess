package Arkess::Event::Registered;

use strict;

sub new {
  my $package = shift;
  my ($callback, $bus) = @_;

  return bless {
    callback => $callback,
    bus      => $bus
  }, $package;
}

sub execute {
  my ($self, @args) = @_;

  return $self->{callback}->(@args);
}

sub unregister {
  my $self = shift;

  $self->{bus}->unbind($self);
}

1;
__END__
=head1 NAME
Arkess::Event::Registered - An event which is registered with an Event::Bus.
Returned as the result of registering a callback so that it can be unregistered
upon completion if necessary
