use SDL;
use SDL::Mixer;
use SDL::Mixer::Channels;
use SDL::Mixer::Effects;
use SDL::Mixer::Samples;

SDL::Mixer::open_audio( 44100, SDL::Constants::AUDIO_S16, 2, 1024 );

my $playing_channel = SDL::Mixer::Channels::play_channel( -1, SDL::Mixer::Samples::load_WAV('assets/sounds/Shamisen-C4.wav'), -1 );
SDL::delay(2000);

SDL::Mixer::close_audio();
SDL::quit();
