package Arkess::Component::UI::Button;

use strict;
use SDLx::Text;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Clickable',
    'Arkess::Component::Colored'
  ];
}

sub initialize {
  my ($self, $text) = @_;

  $self->{text} = $text;
  $self->{message} = SDLx::Text->new();
}

sub exportMethods {
  my $self = shift;

  return {

    setText => sub {
      my ($self, $text) = @_;

      $self->{text} = $text;
    },

    getText => sub {
      return $self->{text};
    },

    render => sub {
      my $cob = shift;

      my $app = $cob->getRenderer();
      my $message = $self->{message};
      my ($x, $y) = $cob->getCoordinates();
      my ($width, $height) = $cob->getDimensions();

      $message->x($x);
      $message->y($y);
      $app->draw_rect([$x, $y, $width, $height], $cob->getColor());
      $message->write_to($app, $self->{text});
    }
  }
}

1;
