package Arkess::IO::Terminal::Command::Builtin::Help;
#
# List available commands
#

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub registersAs {
	return 'help';
}

sub execute {
	my ($self, $command) = @_;

	return defined $command ? $self->_describeCommand($command) : $self->_listCommands();
}

sub getDescription {
	return "Lists all available actions or gives the description of an action";
}

sub _listCommands {
	my $self = shift;

	print "Available commands are:\n";
	my $shell = $self->_getShell();
	foreach my $builtin (@{$shell->{builtins}}) { # FIXME don't call it this way
		print "\t" . $builtin->registersAs() . "\n";
	}
	foreach my $action (keys %{$shell->getPlayer()->getActions()}) {
		print "\t$action\n";
	}
	return 1;
}

sub _describeCommand { # show actions for a command
	my ($self, $command) = @_;

	my $shell = $self->_getShell();
	foreach my $builtin (@{$shell->{builtins}}) { # FIXME same
		my $name = $builtin->registersAs();
		if ($name eq $command) {
			my $description = $builtin->getDescription();
			print "$command (shell builtin)\n";
			print  "$description\n" if $description;
			return 1;
		}
	}
	foreach my $action (keys %{$shell->getPlayer()->getActions()}) {
		if ($action eq $command) {
			print "No help available.\n";
			return 1;
		}
	}
}

1;
