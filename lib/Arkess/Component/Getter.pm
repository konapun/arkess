package Arkess::Component::Getter;

use strict;
use base qw(Arkess::Component);

sub finalize {
  my ($self, $owner) = @_;

  $self->{owner} = $owner;
}

sub exportMethods {
  my $self = shift;
  my $owner = $self->{owner};

  return {
    get => sub {
      my ($obj, $key) = @_;
      return $obj->attributes->get($key);
    }
  };
}

1;

__END__

=head1 NAME
Getter - add property getters to an object
