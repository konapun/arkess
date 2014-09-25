package Arkess::Game;

use strict;
use Arkess::Runtime;

sub new {
  my $package = shift;

  return bless {
    runtime => Arkess::Runtime->new()
  }, $package;
}

sub createController {
  my ($self, $character) = @_;


}

sub run {
  
}

1;

__END__
=head1 NAME
Arkess::Game - An easy interface into Arkess
