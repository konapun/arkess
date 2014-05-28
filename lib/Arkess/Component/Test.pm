package Arkess::Component::Test;

use strict;
use base qw(Arkess::Core::Component);

sub requires {
  return [
    qw(Arkess::Component::Getter)
  ]
}

sub exportAttributes {
  return {
    name => 'Test'
  }
}

sub exportMethods {
  return {
    get => sub { # TODO: should be automatically required
      my ($obj, $key) = @_;

      return $obj->attributes->get($key);
    },
    greet => sub {
      my $self = shift;

      print "Hello, " . $self->get('name') . "!\n";
    }
  }
}

1;
