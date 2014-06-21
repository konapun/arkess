package Arkess::Runtime;

use strict;
use Arkess::Timer;

sub new {
    my $package = shift;

    return bless {
      controllers => [],
      running     => 0,
      timer       => Arkess::Timer->new(60) # 60 fps
    }, $package;
}

sub setFPS {
  my ($self, $fps) = @_;

  $self->{timer}->setFPS($fps);
}

sub stop {
  shift->{running} = 0;
}

sub run {
  my $self = shift;

  my $timer = $self->{timer};
  $timer->set();
  while ($self->{running}) {
    foreach my $controller (@{$self->{controllers}}) {
      $controller->process();
    }

    $timer->tick();
  }
}

1;

__END__
=head1 NAME
Arkess::Runtime - handle game loop
