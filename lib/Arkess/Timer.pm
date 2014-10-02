package Arkess::Timer;

use strict;
use Time::HiRes qw(gettimeofday tv_interval usleep);

sub new {
  my $package = shift;
  my $fps     = shift;

  my $self = bless {
    fps          => $fps,
    sleepTime    => undef,
    lastTick     => undef,
    lastInterval => undef
  }, $package;

  $self->_calculateSleepTime();
  return $self;
}

sub getFPS {
  return shift->{fps};
}

sub getTime {
  return shift->{lastTick};
}

sub getInterval {
  return shift->{lastInterval} * 1000;
}

# Set the clock
sub set {
  shift->{lastTick} = [gettimeofday()];
}

sub setFPS {
  my ($self, $fps) = @_;

  $self->{fps} = $fps;
  $self->_calculateSleepTime();
}

sub tick {
  my $self = shift;

  if (defined $self->{lastTick}) {
    my $interval = tv_interval($self->{lastTick});
    $self->{lastInterval} = $interval;
    my $sleep = $self->{sleepTime} - $interval;
    $sleep = 0 unless $sleep > 0; # Timer lag - can't negative sleep

    usleep($sleep);
  }

  $self->{lastTick} = [gettimeofday()];
}

sub _calculateSleepTime {
  my $self = shift;

  my $fps = $self->{fps};
  my $sleepTime = 1_000_000 / $fps; # microseconds
  $self->{sleepTime} = $sleepTime;

  return $sleepTime;
}

1;

__END__
=head1 NAME
Arkess::Timer - Game main loop control
