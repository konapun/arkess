package Arkess::Data::Format::JSON;

use strict;

sub new {
  my $package = shift;

  return bless {
    height => 0,
    layers => []
  }, $package;
}

sub parse {
  my ($self, $json) = @_;


}

sub parseFile {

}

sub _readLayers {

}


1;
