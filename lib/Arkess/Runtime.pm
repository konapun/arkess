package Arkess::Runtime;

use strict;
use Arkess::IO::Controller;
use Arkess::IO::Window;
use Arkess::IO::Renderer;
use Arkess::Event::Bus;
use Arkess::Event::Queue;
use Arkess::Event;
use Arkess::Timer;

sub new {
    my $package = shift;

    my $self = bless {
      controllers => [], # FIXME use object instead for easy removes (Take from Cobsy::Core)
      entities    => [], # FIXME use object instead for easy removes
      running     => 0,
      eventBus    => Arkess::Event::Bus->new(),
      eventQueue  => Arkess::Event::Queue->new(),
      timer       => Arkess::Timer->new(60), # 60 fps
      renderer    => Arkess::IO::Renderer->new(), # TODO
    }, $package;

    $self->_configure();
    return $self;
}

sub setWindowOptions {
  my ($self, $args) = @_;

  $self->{renderer}->setWindowOptions($args);
}

sub setFPS {
  my ($self, $fps) = @_;

  $self->{timer}->setFPS($fps);
}

sub addEntity {
  my ($self, $entity) = @_;

  push(@{$self->{entities}}, $entity);
  if ($entity->attributes->has('renderable')) {
    $self->{renderer}->addEntity($entity);
  }
}

sub createEntity {
  my ($self, $args) = @_;

  my $entity = Arkess::Object->new($args);
  $self->addEntity($entity);
  return $entity;
}

sub createController {
  my ($self, $character, $bindings) = @_;

  my $controller = Arkess::IO::Controller->new($character, $bindings);
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
  $renderer->initialize();
  while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::LOOP_START);
    DEQ: while (my $event = $eventQueue->dequeue()) { # process SDL events
      foreach my $controller (@{$self->{controllers}}) {
        next DEQ if $controller->process($event); # first controller to accept event consumes it
      }
    }

    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);
    $renderer->render();
    $eventBus->trigger(Arkess::Event::AFTER_RENDER);

    $eventQueue->refresh();
    $timer->tick();
  }
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

sub _configure {
  my $self = shift;

  $self->createController(undef, { # controller to handle window events
    Arkess::IO::Window::WIN_QUIT => sub {
      $self->stop();
    }
  });
}

1;

__END__
=head1 NAME
Arkess::Runtime - handle game loop
