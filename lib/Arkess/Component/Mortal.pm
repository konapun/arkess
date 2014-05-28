package Arkess::Component::Mortal;

use strict;
use base qw(Cobsy::Component);

sub require {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $hp) = @_;

  $hp = 10 unless defined $hp;
  $self->{hp} = $hp;
}

sub exportAttributes {
  return {
    hp => shift->{hp}
  }
}

sub exportMethods {
  my $self = shift;

  return {
    isAlive => sub {
      my $cob = shift;

      return $cob->get('hp') > 0;
    },
    takeDamage => sub {
      my ($cob, $damage) = @_;

      $damage = 1 unless defined $damage;
      $cob->set('hp', $cob->get('hp') - $damage);
      return $cob->get('hp');
    }
  }
}
1;
