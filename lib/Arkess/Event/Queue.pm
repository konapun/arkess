package Arkess::Event::Queue;

use strict;
use SDL::Events;
use SDL::Event;

sub new {
  my $package = shift;

  return bless {
    events => [],
  }, $package;
}

sub wait {
  my $self = shift;

  my $event = SDL::Event->new();
  SDL::Events::wait_event($event);
  return $event;
}

sub dequeue {
  my $self = shift;

  return shift(@{$self->{events}});
}

sub hasEvents {
  return scalar(@{shift->{events}}) > 0;
}

sub events {
  return @{shift->{events}};
}

sub refresh {
  my $self = shift;

  my $event = SDL::Event->new();
  while (SDL::Events::poll_event($event)) {
    push(@{$self->{events}}, $event);
  }
}

sub clear {
  shift->{events} = [];
}

1;

__END__
=head1 NAME
Arkess::Event::Queue - Interface into the SDL::Events
