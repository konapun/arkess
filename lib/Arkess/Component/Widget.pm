package Arkess::Component::Widget;

use strict;
use SDLx::Surface;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $opts) = @_;

  $opts = {} unless $opts;
  $opts->{width} ||= 500;
  $opts->{height} ||= 70;
  $opts->{x} ||= 0;
  $opts->{y} ||= 0;
  $opts->{color} ||= 0x646464CC;
  $opts->{text} ||= "";

  $self->{opts} = $opts;
  $self->{visible} = defined $opts->{visible} ? $opts->{visible} : 1;
  $self->{coords} = [$opts->{x}, $opts->{y}];
  $self->{text} = $opts->{text};
  $self->{widget} = SDLx::Surface->new(
    width  => $opts->{width},
    height => $opts->{height},
    color  => $opts->{color}
  );
}

sub exportMethods {
  my $self = shift;

  return {

    setVisibility => sub {
      my ($cob, $visibility) = @_;

      $self->{visible} = $visibility;
    },

    toggleVisibility => sub {
      $self->{visible} = !$self->{visible};
    },

    setColor => sub {
      my ($cob, $rgba) = @_;

      # TODO: This needs to create a new surface since dimensions are fixed
    },

    writeText => sub {
      my ($cob, $text) = @_;

      $self->{widget} = $self->_createSurface($self->{opts});
      $self->{text} = $text;
    },

    render => sub {
      my $cob = shift;

      if ($self->{visible}) {
        my $widget = $self->{widget};
        my $renderer = $cob->getRenderer();

        if ($self->{text}) {
          $widget->draw_gfx_text( [10,10], [20,20,20,20], $self->{text});
        }
        $widget->blit($renderer, undef, $self->{coords});
      }
    }

  };
}

sub _createSurface {
  my ($self, $opts) = @_;

  return SDLx::Surface->new(
    width  => $opts->{width},
    height => $opts->{height},
    color  => $opts->{color}
  );
}

1;
