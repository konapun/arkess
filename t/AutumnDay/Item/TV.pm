package AutumnDay::Item::TV;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'AutumnDay::Item' => [],
  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  my $status = $self->{on} ? 'on' : 'off';
  $cob->setName('television');
  $cob->setDescription('A 42" LED television. It is currently ' . $status, 'A 42" LED television');

  $cob->wrapAsActioned([
    'turnOn',
    'turnOff',
    'changeChannel',
    'play'
  ]);
}

sub initialize {
  my $self = shift;

  $self->{on} = 0;
  $self->{channels} = {
    static => {
      dialog => [
        'PSHHHHHH'
      ]
    },
    1 => {
      dialog => [
        'Testing channel 1',
        'Continuing test'
      ]
    },
    2 => {
      dialog => [
        'Channel 2'
      ]
    },
    5 => {
      dialog => [
        'Testing channel 5',
        'Chan 5 (cont 1)',
        'Chan 5 (cont 2)'
      ]
    }
  };
  $self->{currentChannel} = 1;
  $self->{dialogLine} = 0;
}

sub exportMethods {
  my $self = shift;

  return {

    turnOn => sub {
      $self->{on} = 1;
    },

    turnOff => sub {
      $self->{off} = 0;
    },

    changeChannel => sub {
      my ($self, $channel) = @_;

      $channel ||= $self->{currentChannel}++;
      $self->{dialogLine} = 0;
    },

    play => sub {
      if ($self->{on}) {
        my $chan = $self->{channels}->{$self->{currentChannel}} || $self->{channels}->{static};
        my $dialog = $chan->{dialog}->[$self->{dialogLine}++];
        $self->{dialogLine} = 0 if $self->{dialogLine} >= scalar @{$chan->{dialog}};

        print $dialog . "\n";
      }
    }

  };
}

1;
