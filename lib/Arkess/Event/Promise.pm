package Arkess::Event::Promise;

use strict;

use constant PENDING => 0;
use constant FULFILLED => 1;
use constant REJECTED => 2;

# Create a promise from a function that takes two parameters:
#  resolve: A function which marks this promise as resolved
#  reject: A function that marks this promise as rejected
sub new {
  my $package = shift;
  my $sub = shift;

  my $self = bless {
    sub    => $sub,
    state  => PENDING,
    accept => [],
    reject => []
  }, $package;

  print "HERE\n";
  $sub->(sub { $self->resolve() }, sub { $self->reject() });
  return $self;
}

sub all {

}

sub race {

}

sub reject {
  my ($self, $reason) = @_;

  $self->{state} = REJECTED;
  foreach my $reject (@{$self->{reject}}) {
    $reject->($reason);
  }
}

sub resolve {
  my ($self, $value) = @_;

  $self->{state} = FULFILLED;
  foreach my $accept (@{$self->{accept}}) {
    $accept->($value);
  }
}

sub then {
  my ($self, $onFulfilled, $onRejected) = @_;

  push(@{$self->{accept}}, $onFulfilled) if $onFulfilled;
  push(@{$self->{reject}}, $onRejected) if $onRejected;
  return Arkess::Event::Promise->new(sub {
    my ($resolve, $reject) = @_;

    print "TODO\n";
  });
}

sub catch {
  my ($self, $sub) = @_;


}

1;

__END__
=head1 NAME
Arkess::Event::Promise - A chainable unit representing a delayed computation
conforming to Mozilla's API (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise).
This is a Promises/A+ implementation.
