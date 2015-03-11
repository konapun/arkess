package Arkess::Component::Mortal;

use strict;
use base qw(Arkess::Component);

sub require {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $max, $hp) = @_;

  $max = 10 unless defined $max;
  $hp = $max unless defined $hp;

  die "HP ($hp) must be below max ($max)" if $hp > $max;
  $self->{max} = $max;
  $self->{hp} = $hp;
}

sub exportAttributes {
  return {
    isMortal => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    # Return 0 or 1 depending on whether the Cob is alive
    isAlive => sub {
      return shift->get('hp') > 0;
    },

    # Return HP for this Cob
    getHP => sub {
      return shift->get('hp');
    },

    # Inflict damage upon this Cob
    takeDamage => sub {
      my ($cob, $damage) = @_;

      $damage = 1 unless defined $damage;
      my $hp = $cob->get('hp') - $damage;
      $cob->set('hp', $hp);
      $cob->trigger('die') if $hp <= 0;
      return $hp;
    },

    # Replentish health by a given amount (refill until full otherwise)
    refillHealth => sub {
      my ($cob, $amount) = @_;

      $amount = $self->{max} unless defined $amount;
      my $hp = $self->{hp} + $amount;
      $hp = $self->{max} if ($hp > $self->{max});
      $self->{hp} = $hp;
    }

  };
}

1;
