package Arkess::Component::Clickable;

use strict;
use Arkess::Event::Bus;
use Arkess::IO::Mouse;
use Arkess::IO::Mouse::EventType;
use base qw(Arkess::Component);

sub requires {
  my ($self, $requires) = @_;

  return [
    'Arkess::Component::Observable',
    'Arkess::Component::2D', #To get width/height
    'Arkess::Component::Deactivatable',
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $controller) = @_;

  $self->{bound} = 1; # Bound clicks to object
  $self->{controller} = $controller;
  $self->{events} = Arkess::Event::Bus->new();
  $self->{cursorHidden} = 0;
}

sub finalize {
  my ($self, $cob) = @_;

  if (!$self->{controller}) { # automatically find controller
    $cob->whenRuntimeAvailable(sub {
      my $runtime = $cob->getRuntime();
      my $controller = $runtime->createController();
      $controller->setPlayer($cob);
      $self->{controller} = $controller;
      $self->_configureController($controller);
    });
  }
  else {
    $self->_configureController($self->{controller});
  }
}

sub exportAttributes {
  return {
    clickable => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {

    disableMouse => sub {
      my $cob = shift;

      my $exports = $self->exportMethods();
      foreach my $key (keys %$exports) {
        next if $key eq 'disableMouse' || $key eq 'enableMouse';
        $cob->deactivate($key);
      }
    },

    enableMouse => sub {
      my $cob = shift;

      my $exports = $self->exportMethods();
      foreach my $key (keys %$exports) {
        $cob->activate($key);
      }
    },

    boundClickToObject => sub {
      my ($cob, $bound) = @_;

      $self->{bound} = $bound;
    },

    showCursor => sub {
      Arkess::IO::Mouse::show_cursor();
      $self->{cursorHidden} = 0;
    },

    hideCursor => sub {
      Arkess::IO::Mouse::hide_cursor();
      $self->{cursorHidden} = 1;
    },

    toggleCursor => sub {
      my $cob = shift;

      $self->{cursorHidden} ? $cob->showCursor() : $cob->hideCursor();
    },

    getController => sub {
      return $self->{controller};
    },

    onClick => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('click', $sub);
    },

    onUnclick => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('unclick', $sub);
    },

    onHover => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('hover', $sub);
    },

    onUnhover => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('unhover', $sub);
    },

    onMouseMove => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('mousemove', $sub);
    },

    onDrag => sub {
      my ($cob, $sub) = @_;

      return $self->{events}->bind('drag', $sub);
    }

  };
}

sub _configureController {
  my ($self, $controller) = @_;

  my $dragging = 0;
  my $hovering = 0;
  my $dragStartEvent = undef;
  $controller->bind(Arkess::IO::Mouse::EventType::BTN_DOWN, sub {
    my ($cob, $event) = @_;

    $dragging = 1;
    $dragStartEvent = $event;
    $self->{events}->trigger('click', $event) if $self->_withinBounds($cob, $event);
  });
  $controller->bind(Arkess::IO::Mouse::EventType::BTN_UP, sub {
    my ($cob, $event) = @_;

    $dragging = 0;
    $self->{events}->trigger('unclick', $event) if $self->_withinBounds($cob, $event);
  });
  $controller->bind(Arkess::IO::Mouse::EventType::MOVE, sub {
    my ($cob, $event) = @_;

    if ($self->_withinBounds($cob, $event)) {
      $self->{events}->trigger('mousemove', $event);
      $self->{events}->trigger('drag', $dragStartEvent, $event) if ($dragging);
      if (!$hovering) {
        $self->{events}->trigger('hover', $event);
        $hovering = 1;
      }
    }
    else {
      $self->{events}->trigger('unhover', $event);
      $hovering = 0;
    }
  });
}

sub _withinBounds {
  my ($self, $cob, $event) = @_;

  return 1 unless $self->{bound};
  my ($clickX, $clickY) = ($event->button_x, $event->button_y);
  my ($x, $y) = $cob->getCoordinates();
  my ($width, $height) = $cob->getDimensions();
  return ($clickX > $x && $clickX < $x + $width) && ($clickY > $y && $clickY < $y + $height);
}

1;

__END__
=head1 NAME
Arkess::Component::Clickable - A component that allows an object to respond to
clicks
