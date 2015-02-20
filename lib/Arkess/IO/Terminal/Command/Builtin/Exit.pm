package Arkess::IO::Terminal::Command::Builtin::Exit;
#
# Exit game
#

use strict;

sub new {
	my $package = shift;
	my $shell = shift;

	return bless {
		shell => $shell,
	}, $package;
}

sub registersAs {
	return 'exit';
}

sub execute {
	shift->{shell}->getEnvironment()->stop();
	return 1;
}

1;
