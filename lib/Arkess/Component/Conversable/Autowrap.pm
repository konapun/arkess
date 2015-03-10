package Arkess::Component::Conversable::Autowrap;

use strict;

sub new {
  my $package = shift;
  my $toWrap = shift;

  my $wrapped;
  my $ref = ref $toWrap;
  if ($ref eq 'ARRAY') {
    $wrapped = sub {
      return $toWrap->[int(rand(scalar(@$toWrap)))];
    };
  }
  elsif ($ref eq 'CODE') {
    $wrapped = $toWrap;
  }
  else {
    $wrapped = sub {
      return $toWrap;
    };
  }

  return bless {
    wrapped => $wrapped
  }, $package;
}

sub execute {
  my ($self, @args) = @_;

  return $self->{wrapped}->(@args);
}

1;
