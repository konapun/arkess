package Arkess::Component::2D::Platform;

use strict;
use base qw(Arkess::Component);

sub require {
  return [
    'Arkess::Component::Collidable',
    'Arkess::Component::Image'
  ];
}

1;

__END__
=head1 NAME
Arkess::Component::2D::Platform
