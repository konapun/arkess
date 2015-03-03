package Arkess::Sound::Player;

use strict;
use threads ( exit => 'threads_only' ); # So sounds can be played nonblocking
use SDL;
use SDL::Mixer;
use SDL::Mixer::Channels;
use SDL::Mixer::Effects;
use SDL::Mixer::Samples;

sub new {
  my $package = shift;
  my $sounds = shift || {};

  return bless {
    playing => 0,
    muted   => 0,
    sounds  => $sounds # key => val pairs where values are filenames
  }
}

sub mute {
  shift->{muted} = 1;
}

sub unmute {
  shift->{muted} = 0;
}

sub isMuted {
  return shift->{muted};
}

sub isPlaying {
  return shift->{playing};
}

sub loadSound {
  my ($self, $name, $file) = @_;

  die "Can't load sound '$name': No such file '$file'" unless -e $file;
  $self->{sounds}->{$name} = $file;
}

sub playSound {
  my ($self, $sound) = @_;

  if (!$self->isMuted()) {
    my $file = $self->{sounds}->{$sound};
    die "Can't play sound '$sound': No sound file loaded" unless $file;

    threads->create(sub { # TODO: Set $self->{playing}
      SDL::Mixer::open_audio(44100, SDL::Constants::AUDIO_S16, 2, 1024);

      my $playing_channel = SDL::Mixer::Channels::play_channel(-1, SDL::Mixer::Samples::load_WAV($file), -1);
      SDL::delay(2000);

      SDL::Mixer::close_audio();
    });#->detach(); # FIXME detach SHOULD work... (perl bug?)
  }
}

1;
