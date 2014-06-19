package Arkess::Component::Damaging;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $damage) = @_;

  $damage = 1 unless defined $damage;
  $self->{power} = $damage;
}

sub exportAttributes {
  my $self = shift;

  return {
    
  };
}

sub exportMethods {
  my $self = shift;

  return {

  };
}

1;

__END__
=head1 NAME
Arkess::Component::Damaging - Component for inflicting damage on an Arkess
object which registers the Mortal component
