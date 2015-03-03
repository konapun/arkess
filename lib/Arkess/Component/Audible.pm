package Arkess::Component::Audible;

use strict;
use Arkess::Sound::Player;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $sounds) = @_;

  $self->{soundPlayer} = Arkess::Sound::Player->new($sounds);
}

sub exportMethods {
  my $self = shift;

  return {

    addSound => sub {
      my ($cob, $name, $file) = @_;

      $self->{soundPlayer}->loadSound($name, $file);
    },

    mute => sub {
      $self->{soundPlayer}->mute();
    },

    unmute => sub {
      $self->{soundPlayer}->unmute();
    },

    isMuted => sub {
      return $self->{soundPlayer}->isMuted();
    },

    isPlaying => sub {
      return $self->{soundPlayer}->isPlaying();
    },

    playSound => sub {
      my ($cob, $sound) = @_;

      $self->{soundPlayer}->playSound($sound);
    }

  };
}

1;

__END__
=head1 NAME
Arkess::Component::Audible - A component for a cob which makes noise
