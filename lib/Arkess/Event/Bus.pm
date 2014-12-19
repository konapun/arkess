package Arkess::Event::Bus;

use strict;
use Arkess::Event::Registered;

sub new {
  return bless {
    registry => {}
  }, shift;
}

# Binds an action to a signal and returns a wrapped event which can be unbound
# from this bus via the action's `unregister`
sub bind {
	my ($self, $signal, $action) = @_;

	$self->{registry}->{$signal} = [] unless defined($self->{registry}->{$signal});
  my $registeredEvent = Arkess::Event::Registered->new($action, $self);
	push(@{$self->{registry}->{$signal}}, $registeredEvent);

  return $registeredEvent;
}

sub unbind {
  my ($self, $event) = @_;

  no warnings qw(internal);
  while (my ($signal, $eventsForSignal) = each %{$self->{registry}}) {
    my $index = 0;
    foreach my $signalEvent (@$eventsForSignal) {
      if ($signalEvent == $event) {
        splice(@$eventsForSignal, $index, 1);
        return 1; # found and removed event
      }
      $index++;
    }
  }

  return 0; # event not found
}

sub trigger {
	my ($self, $eventKey, @args) = @_;

	foreach my $event (@{$self->{registry}->{$eventKey}}) {
		$event->execute(@args);
	}
}

1;

__END__
=head1 NAME
Arkess::Event::Bus - A single-channel event bus
