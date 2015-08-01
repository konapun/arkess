package Arkess::Component::RuntimeAdapter;

use strict;
use base qw(Arkess::Component);

sub initialize {
  my ($self, $methods, $attributes) = @_;

  $methods ||= {};
  $attributes ||= {};
  $self->{methods} = $methods;
  $self->{attributes} = $attributes;
}

sub exportMethods {
  my $self = shift;

  return {

    addMethod => sub {
      my ($cob, $methodName, $sub) = @_;
      
      $cob->methods->set($methodName, $sub);
    },

    addAttribute => sub {
      my ($cob, $attrName, $attrVal) = @_;

      $cob->attributes->set($attrName, $attrVal);
    }

  };
}

sub finalize {
  my ($self, $cob) = @_;

  while my ($key, $val) = each(%{$self->{attributes}}) {
    $cob->addAttribute($key, $val);
  }
  while my ($key, $val) = each(%{$self->{methods}}) {
    $cob->addMethod($key, $val);
  }
}

1;
__END__
=head1 NAME
Arkess::Component::RuntimeAdapter - Convenience wrapper for adding attributes and methods at runtime
