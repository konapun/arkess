package Arkess::IO::Controller;

use strict;

sub new {
  my $package = shift;
  my $character = shift;

  return bless {
    character => $character
  }, $package;
}

sub process {
  my ($self, $event) = @_;


}
1;
