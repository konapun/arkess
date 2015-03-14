package Arkess::Component::Observable::SubCompare;

use strict;
use B::Deparse;
use Digest::MD5 qw(md5);

# http://stackoverflow.com/questions/5589397/printing-out-the-code-of-an-anonymous-subroutine

sub new {
  my $package = shift;

  return bless {
    deparse => B::Deparse->new(),
    wrapped => {}
  }, $package;
}

sub isWrapped {
  my ($self, $name, $code) = @_;

  my $source = $self->{deparse}->coderef2text($code);
  my $hashedSource = md5($source);
  return 1 if defined $self->{wrapped}->{$hashedSource};
  $self->{wrapped}->{$hashedSource} = 1;
  return 0;
}

1;

__END__
=head1 NAME
Arkess::Component::Observable::Sub -
