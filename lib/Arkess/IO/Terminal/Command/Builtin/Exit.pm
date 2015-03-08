package Arkess::IO::Terminal::Command::Builtin::Exit;
#
# Exit game
#

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub registersAs {
	return 'exit';
}

sub execute {
	shift->{shell}->getEnvironment()->stop();
	return 1;
}

1;
