package Arkess::Component::Magical;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Getter'
  ];
}

sub initialize {
  my ($self, $mp) = @_;

  $mp = 10 unless defined $mp; # maximum MP for this Cob
  $self->{mp_max} = $mp;
  $self->{mp} = $mp;
}

sub exportAttributes {
  return {
    mp => $self->{mp}
  }
}

sub exportMethods {
  return {

    getMP => sub {
      return shift->get('mp');
    },

    getMaxMP => sub {
      return shift->get('mp_max');
    },

    restoreMP => sub {
      my ($cob, $increment) = @_;

      $increment = $self->{mp} unless defined $increment;
      my $max = $cob->get('mp_max');
      my $current = $cob->getMP();
      if ($current + $increment > $max) {
        $cob->set('mp', $max);
      }
      else {
        $cob->set('mp', $current + $increment)
      }
    },

    setMaxMP => sub {
      my ($cob, $max) = @_;

      $cob->set('mp_max', $max);
      $cob->set('mp', $max) if $cob->getMP() > $max;
    }

  }
}

1;

__END__
=head1 NAME
Arkess::Component::Magical - Component for an Arkess object which can perform
magic
