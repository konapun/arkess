package Arkess::Event;

use strict;

use constant {
  BEFORE_RENDER   => 'rt_before_render',
  AFTER_RENDER    => 'rt_after_render',
  LOOP_START      => 'rt_loop_start',
  RUNTIME_START   => 'rt_runtime_start',
  RUNTIME_STOP    => 'rt_runtime_stop',
  ENTITY_ADDED    => 'rt_entity_added',
  ENTITY_REMOVED  => 'rt_entity_removed',
  COMPONENT_ADDED => 'rt_component_added'
};

sub getAll {
  return (
    Arkess::Event::BEFORE_RENDER,
    Arkess::Event::AFTER_RENDER,
    Arkess::Event::LOOP_START,
    Arkess::Event::RUNTIME_START,
    Arkess::Event::RUNTIME_STOP,
    Arkess::Event::ENTITY_ADDED,
    Arkess::Event::ENTITY_REMOVED,
    Arkess::Event::COMPONENT_ADDED
  );
}

1;

__END__
=head1 NAME
Arkess::Event - An enumeration of all standard events fired by the Arkess
Runtime
