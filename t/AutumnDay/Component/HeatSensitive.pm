package AutumnDay::Component::HeatSensitive;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $current, $high, $low) = @_;

  $self->{current} = $current;
  $self->{high} = $high;
  $self->{low} = $low;
}

sub exportMethods {
  my $self = shift;

  return {

    setFreezeTemperature => sub {
      my ($cob, $temp) = @_;

      $self->{low} =  $temp;
    },

    setBurnTemperature => sub {
      my ($cob, $temp) = @_;

      $self->{high} = $temp;
    },

    getFreezeTemperature => sub {
      return $self->{low};
    },

    getBurnTemperature => sub {
      return $self->{high};
    },

    getTemperature => sub {
      return $self->{current};
    },

    increaseTemperature => sub {
      my ($cob, $step) = @_;

      $self->{current} += $step;
      $self->_checkTemperature($cob);
    },

    decreaseTemperature => sub {
      my ($cob, $step) = @_;

      $self->{current} -= $step;
      $self->_checkTemperature($cob);
    },

    setTemperature => sub {
      my ($cob, $temp) = @_;

      $self->{current} = $temp;
      $self->_checkTemperature($cob);
    }

  };
}

sub _checkTemperature {
  my ($self, $cob) = @_;

  my $current = $self->{current};
  if ($current > $high) {
    $cob->trigger('burn');
  }
  if ($current < $low) {
    $cob->trigger('freeze');
  }
}
1;
