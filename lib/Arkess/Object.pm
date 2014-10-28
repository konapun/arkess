package Arkess::Object;

use strict;
use base qw(Cobsy::Object);

sub new {
  my $package = shift;
  my $additional = shift;

  my $base = $package->SUPER::new([
    'Arkess::Component::Observable',
    'Arkess::Component::Getter',
    'Arkess::Component::AttributeChecker',
    'Arkess::Component::MethodChecker',
    'Arkess::Component::RuntimeAware'
  ]);

  return $base->extend($additional);
}

1;

__END__
=head1 NAME
Arkess::Object - A Cobsy object initialized with some components to be inherited
by all other Arkess::Objects
