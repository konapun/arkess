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
	my ($self, $command) = @_;

	return defined $command ? $self->_describeCommand($command) : $self->_listCommands();
}

sub _listCommands {
	my $self = shift;

	print "Available commands are:\n";
	my $shell = $self->{shell};
	foreach my $builtin (@{$shell->{builtins}}) {
		print "\t" . $builtin->registersAs() . "\n";
	}
	foreach my $action (keys %{$shell->getPlayer()->getActions()}) {
		print "\t$action\n";
	}
	return 1;
}

sub _describeCommand {
	my ($self, $command) = @_;

	my $shell = $self->{shell};
	foreach my $builtin (@{$shell->{builtins}}) {
		my $name = $builtin->registersAs();
		if ($name eq $command) {
			print "FOUND\n";
			return 1;
		}
	}
	foreach my $action (keys %{$shell->getPlayer()->getActions()}) {
		if ($action eq $command) {
			print "FOUND (action)\n";
			return 1;
		}
	}
}

1;
