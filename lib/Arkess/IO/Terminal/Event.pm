package Arkess::IO::Terminal::Event;

use strict;

use constant {
  COMMAND_SUCCEEDED => 'term_command_succeeded',
  COMMAND_FAILED    => 'term_command_failed',
};

sub getAll {
  return (
    Arkess::IO::Terminal::Event::COMMAND_SUCCEEDED,
    Arkess::IO::Terminal::Event::COMMAND_FAILED,
  );
}

1;
__END__
=head1 NAME
Arkess::IO::Terminal::Event - An enumeration of all standard events fired by the
Arkess terminal for use with the plugin system
