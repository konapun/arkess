package Arkess::IO::Controller::Hub;

use strict;
use Arkess::Event::Queue;

sub new {
  my $package = shift;
  my $stopOnFirstAccept = shift;

  return bless {
    stopOnFirst => defined $stopOnFirstAccept ? $stopOnFirstAccept : 0,
    eventQueue  => Arkess::Event::Queue->new(),
    controllers => []
  }, $package;
}

sub addController {
  my ($self, $controller) = @_;

  push(@{$self->{controllers}}, $controller);
}

sub processEvents {
  my $self = shift;

  my $eventQueue = $self->{eventQueue};
  my @controllers = @{$self->{controllers}};
  DEQ: while (my $event = $eventQueue->dequeue()) { # process SDL events
    foreach my $controller (@controllers) {
      next DEQ if $controller->process($event); # first controller to accept event consumes it
    }
  }
  $eventQueue->refresh();
}

sub _distribute {
  my ($self, $signal) = @_;

  my $stop = $self->{stopOnFirstAccept};
  foreach my $controller (@{$self->{controllers}}) {
    last if $controller->process($signal) && $stop;
  }
}

1;

__END__
=head1 NAME
Arkess::IO::Conroller::Hub - Relay events to controllers
