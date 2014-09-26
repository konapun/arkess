package Arkess::Event::Bus;

use strict;

sub new {
  return bless {
    registry => {}
  }, shift;
}

sub bind {
	my ($self, $signal, $action) = @_;

	$self->{registry}->{$signal} = [] unless defined($self->{registry}->{$signal});
	push(@{$self->{registry}->{$signal}}, $action);
}

sub trigger {
	my ($self, $eventKey, @args) = @_;

	foreach my $event (@{$self->{registry}->{$eventKey}}) {
		$event->(@args);
	}
}

1;

__END__
=head1 NAME
Arkess::Event::Bus - A single-channel event bus
