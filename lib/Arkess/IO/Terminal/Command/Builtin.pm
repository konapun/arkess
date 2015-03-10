package Arkess::IO::Terminal::Command::Builtin;
#
# Abstract class for builtin commands
#

use strict;

sub new {
	my $package = shift;
	my $shell = shift;

	return bless {
		shell => $shell
	}, $package;
}

sub registersAs {
	die "Builtin command must provide an implementation for `registersAs`";
}

sub execute {
	die "Builtin command must provide an implementation for `execute`";
}

sub getDescription {
	return "No description available";
}

sub _getShell {
	return shift->{shell};
}

1;
