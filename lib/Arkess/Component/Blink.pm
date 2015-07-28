package Arkess::Component::Blink; # Root in Arkess::Component::Graphics::FX::Blink or something

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Timed',
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my ($self, $interval, $runImmediately) = @_;

  $interval = 200 unless defined $interval;
  $runImmediately = 1 unless defined $runImmediately;
  $self->{interval} = $interval;
  $self->{eventHandle} = undef;
  $self->{runImmediately} = $runImmediately;
}

sub exportMethods {
  my $self = shift;

  return {
    blink => sub {
      my ($cob, $interval) = @_;

      $interval = $self->{interval} unless defined $interval;
      $self->{eventHandle}->unregister() if $self->{eventHandle};
      $self->_registerBlinker($cob, $interval);
    },

    stopBlinking => sub {
      $self->{eventHandle}->unregister() if $self->{eventHandle};
    }
  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $self->_registerBlinker($cob, $self->{interval}) if $self->{runImmediately};
}

sub _registerBlinker {
  my ($self, $cob, $interval) = @_;

  $cob->whenRuntimeAvailable(sub {
    my $handle = $cob->registerTimedEvent(sub {
      $cob->toggleVisibility();
    }, $interval);
    $self->{eventHandle} = $handle;
  });
}
1;
