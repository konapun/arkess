package Arkess::IO::Terminal::Command::Builtin;
#
# Define builtins at runtime
#

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
