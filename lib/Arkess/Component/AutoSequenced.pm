package Arkess::Component::AutoSequenced;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::AnimatedSprite',
    'Arkess::Component::Mobile',
    'Arkess::Component::Observable'
  ];
}

sub initialize {
  my ($self, $sequences) = @_;

  $self->{sequences} = $sequences; # If any, else can be assigned through AnimatedSprite's methods
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->on('move', sub {
    my ($direction, $units) = @_;

    $cob->setSequence($direction) if $direction;
  });
}

1;

__END__
=head1 NAME
Arkess::Component::AutoSequenced - automatically animate movement based on sequence names
