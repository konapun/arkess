package Arkess::Object;

use strict;
use base qw(Cobsy::Object);

sub new {
  my $self = shift->SUPER::new([
    'Arkess::Component::Observable',
    'Arkess::Component::Getter',
    'Arkess::Component::Setter',
    'Arkess::Component::AttributeChecker',
    'Arkess::Component::MethodChecker'
  ]);

  return $self;
}

1;

__END__
=head1 NAME
Arkess::Object - A Cobsy object initialized with some components to be inherited
by all other Arkess::Objects
