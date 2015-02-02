package Arkess::Component::Audible;

use strict;
use SDL::Sound;
use SDL::Mixer;
use SDL::Mixer::Music;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $sound) = @_;

  my $player = SDL::Sound->new();
  $self->{muted} = 0;
  $self->{player} = $player;
  $self->{sound} = $sound;
}

sub exportMethods {
  my $self = shift;

  return {

    setSound => sub {
      return $self->{sound};
    },

    getSound => sub {
      my ($cob, $sound) = @_;

      $self->{sound} = $sound;
    },

    mute => sub {
      $self->{muted} = 1;
    },

    unmute => sub {
      $self->{muted} = 0;
    },

    isMuted => sub {
      return $self->{muted};
    },

    playSound => sub {
      my ($cob, $sound) = @_;

      if (!$cob->isMuted()) {
        $sound = defined $sound ? $sound : $self->{sound};
        $self->{player}->play($sound);
      }
    }

  };
}

1;

__END__
=head1 NAME
Arkess::Component::Audible - A component for a cob which makes noise
