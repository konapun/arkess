package Arkess::Runtime;

use strict;
use Arkess::IO::Controller;
use Arkess::Graphics::Renderer;
use Arkess::Event::Bus;
use Arkess::Event::Queue;
use Arkess::Event;
use Arkess::Timer;

sub new {
    my $package = shift;

    return bless {
      controllers => [],
      running     => 0,
      eventBus    => Arkess::Event::Bus->new(),
      eventQueue  => Arkess::Event::Queue->new(),
      timer       => Arkess::Timer->new(60), # 60 fps
      renderer    => undef, # TODO
    }, $package;
}

sub setFPS {
  my ($self, $fps) = @_;

  $self->{timer}->setFPS($fps);
}

sub createController {
  my ($self, $character) = @_;

  my $controller = Arkess::IO::Controller->new($character);
  push(@{$self->{controllers}}, $controller);
  return $controller;
}

sub getEventBus {
  return shift->{eventBus};
}

sub stop {
  shift->{running} = 0;
}

sub run {
  my $self = shift;

  my $timer = $self->{timer};
  my $eventBus = $self->{eventBus};
  my $eventQueue = $self->{eventQueue};
  my $renderer = $self->{renderer};

  $eventBus->trigger(Arkess::Event::RUNTIME_START);
  $timer->set();
  $self->{running} = 1;
  while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::LOOP_START);
    DEQ: while (my $event = $eventQueue->dequeue()) { # process SDL events
      foreach my $controller (@{$self->{controllers}}) {
        next DEQ if $controller->process($event); # first controller to accept event consumes it
      }
    }

    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);
    #$renderer->render(); # ->render($screen)
    $eventBus->trigger(Arkess::Event::AFTER_RENDER);

    $eventQueue->refresh();
    $timer->tick();
  }
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

1;

__END__
=head1 NAME
Arkess::Runtime - handle game loop
