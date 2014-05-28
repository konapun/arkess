package Arkess::Object;

use strict;
use base qw(Cobsy::Object);

# An Arkess object is a Cobsy object with a few default components
sub new {
  my $self = shift->SUPER::new(@_)->extend([
    'Arkess::Component::Observable',
    'Arkess::Component::AttributeChecker',
    'Arkess::Component::MethodChecker'
  ]);

  return $self;
}

1;
