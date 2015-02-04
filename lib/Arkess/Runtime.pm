package Arkess::Runtime;

use strict;
use Arkess::IO::Controller;
use Arkess::IO::Controller::Hub;
use Arkess::IO::Window;
use Arkess::IO::Renderer;
use Arkess::Event;
use Arkess::Event::Bus;
use Arkess::Timer;

sub new {
    my $package = shift;
    my $windowArgs = shift;

    my $self = bless {
      entities    => [], # FIXME use object instead for easy removes
      running     => 0,
      eventBus    => Arkess::Event::Bus->new(),
      eventHub    => Arkess::IO::Controller::Hub->new(),
      timer       => Arkess::Timer->new(60), # 60 fps
      renderer    => Arkess::IO::Renderer->new($windowArgs),
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

sub getEntities {
  return @{shift->{entities}};
}

sub addEntity {
  my ($self, $entity) = @_;

  $entity->setRuntime($self);
  push(@{$self->{entities}}, $entity);
  if ($entity->attributes->has('renderable')) {
    $self->{renderer}->addEntity($entity);
  }
  $self->getEventBus()->trigger(Arkess::Event::ENTITY_ADDED);
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
  $self->{eventHub}->addController($controller);
  return $controller;
}

sub getRenderer {
  return shift->{renderer};
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
  my $eventHub = $self->{eventHub};
  my $renderer = $self->{renderer};

  $eventBus->trigger(Arkess::Event::RUNTIME_START);
  $timer->set();
  $self->{running} = 1;
  $renderer->initialize();
  while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::LOOP_START);
    $eventHub->processEvents();
    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);
    $renderer->render();
    $eventBus->trigger(Arkess::Event::AFTER_RENDER);

    $timer->tick();
  }
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

sub _configure {
  my $self = shift;

  my $windowController = $self->createController(undef); # controller to handle window events
  $windowController->bind(Arkess::IO::Window::WIN_QUIT, sub {
    $self->stop();
  });
}

1;

__END__
=head1 NAME
Arkess::Runtime - handle game loop
