package Arkess::IO::Terminal::Command::DefinedBuiltin;

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub new {
	my $package = shift;
	my ($name, $sub) = @_;

	return bless {
		name => $name,
		execute => $sub,
	}, $package;
}

sub registersAs {
	return shift->{name};
}

sub execute {
	return shift->{execute}->(@_);
}

1;
