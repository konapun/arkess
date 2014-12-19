#Arkess
A hybrid component-entity game engine for Perl built on Cobsy and SDL (**UNDER ACTIVE DEVELOPMENT, NOT READY TO USE**).

## Concepts
Arkess is hybrid in the sense that it supports both traditional inheritance (parent-child) and component-entity inheritance (lateral).
If you are unfamiliar with component-entity systems please read [this](http://en.wikipedia.org/wiki/Entity_component_system).

## Standard components
The base Arkess object is a [Cobsy](https://github.com/konapun/cobsy) object with the [Observable](#observable), [Getter](#getter), [AttributeChecker](#attributeChecker), [MethodChecker](#methodChecker), and [RuntimeAware](#runtimeAware)
components mixed in.

### Timed
The Timed component supports the creation of actions to be run repeatedly on a timer. For instance, imagine an item which may grant invincibility to a player before expiring after 10 seconds.

### Observable

### Mobile

### Collidable

### RuntimeAware

## Installation
### Ubuntu
(libalien-sdl-perl, etc)
