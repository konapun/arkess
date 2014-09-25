package Arkess::Runtime;

use strict;
use Arkess::Graphics::Renderer;
use Arkess::Timer;

sub new {
    my $package = shift;

    return bless {
      controllers => [],
      running     => 0,
      timer       => Arkess::Timer->new(60), # 60 fps
      renderer    => undef, # TODO
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
  my $renderer = $self->{renderer};
  $timer->set();
  while ($self->{running}) {
    foreach my $controller (@{$self->{controllers}}) {
      $controller->process();
    }
    
    $renderer->render(); # ->render($screen)
    $timer->tick();
  }
}

1;

__END__
=head1 NAME
Arkess::Runtime - handle game loop
