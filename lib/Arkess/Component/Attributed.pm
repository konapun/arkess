package Arkess::Component::Attributed;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $attributes) = @_;

  $self->{attributes} = $attributes || {};
}

sub exportAttributes {
  return {
    attributed => 1
  };
}

sub exportMethods {
  my $self = shift;

  return {

    setAttribute => sub {
      my ($cob, $key, $val) = @_;

      $self->{attributes}->{$key} = $val;
    },

    getAttribute => sub {
      my ($cob, $key) = @_;

      return $self->{attributes}->{$key};
    },

    removeAttribute => sub {
      my ($cob, $key) = @_;

      delete $self->{attributes}->{$key};
    },

    eachAttribute => sub {
      my ($cob, $sub) = @_;

      foreach my $attrName (keys %{$self->{attributes}}) {
        my $val = $self->{attributes}->{$attrName};
        $sub->($attrName, $val);
      }
    }

  };
}

1;

__END__
=head1 NAME
Arkess::Component::Attributed - A component for entities which have
user-definable attributes
