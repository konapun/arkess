package Arkess::Runtime::Base;

use strict;
use Arkess::Event;
use Arkess::IO::Controller;
use Arkess::IO::Controller::Hub;
use Arkess::Event::Bus;
use Arkess::Timer;

sub new {
    my $package = shift;

    return bless {
      entities    => [], # FIXME use object instead for easy removes
      running     => 0,
      eventBus    => Arkess::Event::Bus->new(),
      eventHub    => Arkess::IO::Controller::Hub->new(),
      timer       => Arkess::Timer->new(60), # 60 fps
    }, $package;
}

sub getEntities {
  return @{shift->{entities}};
}

sub addEntity {
  my ($self, $entity) = @_;

  $entity->setRuntime($self);
  push(@{$self->{entities}}, $entity);
  $self->getEventBus()->trigger(Arkess::Event::ENTITY_ADDED);
}

sub createEntity {
  my ($self, $args) = @_;

  my $entity = Arkess::Object->new($args);
  $self->addEntity($entity);
  return $entity;
}

sub removeEntity {
  my ($self, $entity) = @_;

  foreach my $contained (@{$self->{entities}}) {
    if ($entity eq $contained) {
      print "FOUND IT!\n";
    }
  }
}

sub createController {
  my ($self, $character, $bindings) = @_;

  my $controller = Arkess::IO::Controller->new($character, $bindings);
  $self->{eventHub}->addController($controller);
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
  my $eventHub = $self->{eventHub};

  $eventBus->trigger(Arkess::Event::RUNTIME_START);
  $timer->set();
  $self->{running} = 1;
  while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::TICK);
    $eventHub->processEvents();
    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);

    $timer->tick();
  }
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

1;

__END__
=head1 NAME
Arkess::Runtime::Base - handle game loop
