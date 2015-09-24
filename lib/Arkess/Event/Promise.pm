package Arkess::Event::Promise;

use strict;

use constant PENDING => 0;
use constant RESOLVED => 1;
use constant REJECTED => 2;

sub new {
  my $package = shift;
  my $fn = shift;

  return Arkess::Event::Promise::_instantiatePromiseWithState($package, PENDING, $fn);
}

sub resolve {
  my $package = shift;
  my $value = shift;

  return Arkess::Event::Promise::_instantiatePromiseWithState($package, RESOLVED, $value);
}

sub reject {
  my $package = shift;
  my $reason = shift;

  return Arkess::Event::Promise::_instantiatePromiseWithState($package, REJECTED, $reason);
}

sub _instantiatePromiseWithState {
  my ($package, $state, $val) = @_;

  my $fn = undef;
  if (ref $val eq 'CODE') {
    $fn = $val;
    $val = undef;
  }

  my $self = bless {
    state    => $state,
    deferred => undef,
    value    => $val
  }, $package;

  if ($fn) {
    $fn->(
      sub {
        $self->_resolve(@_);
      },
      sub {
        $self->_reject(@_);
      }
    );
  }

  return $self;
}

sub then {
  my ($self, $onResolved, $onRejected) = @_;

  return Arkess::Event::Promise->new(sub {
    my ($resolve, $reject) = @_;

    $self->_handle({
      onResolved => $onResolved,
      onRejected => $onRejected,
      resolve    => $resolve,
      reject     => $reject
    });
  });
}

sub catch {
  my ($self, $sub) = @_;

  return $self->then(undef, $sub);
}

sub done {
  my ($self, $sub) = @_;

  die "TODO";
}

sub _resolve {
  my ($self, $value) = @_;

  if (ref $value) {
    $value->then(sub {
      $self->_resolve(@_);
    });
    return;
  }

  $self->{state} = RESOLVED;
  $self->{value} = $value;
  if ($self->{deferred}) {
    $self->_handle($self->{deferred});
  }
}

sub _reject {
  my ($self, $reason) = @_;

  $self->{state} = REJECTED;
  $self->{value} = $reason;
  if ($self->{deferred}) {
    $self->_handle($self->{deferred});
  }
}

sub _handle {
  my ($self, $handler) = @_;

  my $state = $self->{state};
  if ($state eq PENDING) {
    $self->{deferred} = $handler;
    return;
  }

  my $handlerCallback;
  my $value = $self->{value};
  if ($state eq RESOLVED) {
    $handlerCallback = $handler->{onResolved};
  }
  else {
    $handlerCallback = $handler->{onRejected};
  }

  unless ($handlerCallback) {
    if ($state eq RESOLVED) {
      $handler->{resolve}->($value);
    }
    else {
      $handler->{reject}->($value);
    }

    return;
  }

  my $ret = $handlerCallback->($value);
  $handler->{resolve}->($ret);
}

1;

__END__
=head1 NAME
Arkess::Event::Promise - A partial Promises/A+ implementation adapted from this
article: http://www.mattgreer.org/articles/promises-in-wicked-detail/#chaining-promises
