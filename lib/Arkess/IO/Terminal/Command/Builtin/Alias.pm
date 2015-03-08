package Arkess::IO::Terminal::Command::Builtin::Alias;
#
# Alias a command (builtin or otherwise)
#

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub registersAs {
	return 'alias';
}

sub execute {
	my ($self, @args) = @_;
	my ($original, $alias) = @args;

	if (!defined $alias) {
		print "Usage: alias <command> <new command>\n";
		return 0;
	}

	my $shell = $self->_getShell();
	foreach my $builtin (@{$shell->{builtins}}) {
		if ($builtin->registersAs() eq $original) {
			push(@{$shell->{builtins}}, Arkess::IO::Terminal::Command::Builtin->new($alias, sub {
				return $builtin->execute(@_);
			}));
			return 1;
		}
	}

	my $user = $shell->getPlayer();
	foreach my $key (keys %{$shell->getPlayer()->getActions()}) {
		if ($key eq $original) {
			print "Adding action $alias for $original\n";
			$user->addAction($alias, sub {
				print "CALLING $key\n";
				return $user->callAction($key, @_);
			});
			return 1;
		}
	}

	print "Command \"$original\" not found\n";
	return 0;
}

1;
