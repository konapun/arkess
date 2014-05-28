package Arkess::Component::Renderable;

use strict;
use base qw(Cobsy::Component);

sub initialize {
  my ($self, $spriteSheet) = @_;

  $self->{spriteSheet} = $spriteSheet;
}

sub exportAttributes {
  return {
    spriteSheet => undef
  };
}

sub exportMethods {
  my $self = shift;

  return {
    render => sub {
      print "TODO\n";
    }
  }
}

1;

__END__

=head1 NAME
Arkess::Component::Renderable - A component for an object which can be rendered
