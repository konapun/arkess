package Arkess::IO::Terminal::Command::Builtin::Help;
#
# List available commands
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
	return 'help';
}

sub execute {
	my $self = shift;

	print "Available commands are:\n";
	my $shell = $self->{shell};
	foreach my $builtin (@{$shell->{builtins}}) {
		print "\t" . $builtin->registersAs() . "\n";
	}

#	foreach my $action ($shell->user()->actions()->keys()) {
#		print "\t$action\n";
#	}

	return 1;
}

1;
