package Arkess::Wiring;

use strict;

# Wiring signals
use constant INITIALIZE => 0;

sub new {
  my $package = shift;

  my $self = bless {
    wires => []
  }, $package;

  $self->_configure();
  return $self;
}

sub wire {
  my ($self, $component, $signal, $handle) = @_;


}

sub _configure {
  my $self = shift;

  $self->wire('Arkess::UI::Button', Wiring::INITIALIZE, sub {

  });
}

1;
__END__
=head1 NAME
Arkess::Wiring - Wiring provides a one-stop location for providing configuration
to Arkess components which may be switched out depending on environment.
