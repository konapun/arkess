package Arkess::Component::Conversable;

use strict;
use Arkess::Component::Conversable::Conversation;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::AttributeChecker',
    'Arkess::Component::RuntimeAware'
  ];
}

sub initialize {
  my $self = shift;

  $self->{conversations} = {};
}

sub exportAttributes {
  return {
    conversable => 1
  }
}

sub exportMethods {
  my $self = shift;

  return {

    whenTalkingTo => sub {
      my ($cob, $player) = @_; # TODO: Eventually, accept player as {name: 'name'} or {object: $objecct}

      my $conversation = Arkess::Component::Conversable::Conversation->new($cob, $player);
      $self->{conversations}->{$player} = $conversation;
      return $conversation;
    },

    talkTo => sub {
      my ($cob, $player) = @_;

      my $conversation = $self->{conversations}->{$player};
      return 0 unless $conversation;

      $conversation->begin($player);
      return 1;
    }

  }
}

1;
