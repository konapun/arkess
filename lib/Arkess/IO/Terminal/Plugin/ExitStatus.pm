package Arkess::IO::Terminal::Plugin::ExitStatus;

use strict;
use base qw(Arkess::IO::Terminal::Plugin);

sub register {
  my ($self, $terminal) = @_;

  $terminal->getEventBus()->bind(Arkess::IO::Terminal::Event::COMMAND_FAILED, sub {
    my $command = shift;
    
    print "COMMAND FAILED!\n";
  })
}

1;
