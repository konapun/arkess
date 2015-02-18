package Arkess::IO::Terminal::Command::Builtin::Alias;
#
# Alias a command (builtin or otherwise)
#

use strict;
use Arkess::IO::Terminal::Command::Builtin;

sub new {
	my $package = shift;
	my $shell = shift;

	return bless {
		shell => $shell,
	}, $package;
}

sub registersAs {
	return 'alias';
}

sub execute {
	my ($self, $args) = @_;
	my ($original, $alias) = $args->all();

	if (!defined $alias) {
		print "Usage: alias <command> <new command>\n";
		return 0;
	}

	my $shell = $self->{shell};
	foreach my $builtin (@{$shell->{builtins}}) {
		if ($builtin->registersAs() eq $original) {
			push(@{$shell->{builtins}}, Arkess::IO::Terminal::Command::Builtin->new($alias, sub {
				return $builtin->execute(@_);
			}));
			return 1;
		}
	}
	while (my ($key, $action) = each %{$shell->user()->actions()->list()}) {
		if ($key eq $original) {
			$shell->user()->actions($alias, sub {
				return $action->call(@_);
			});
			return 1;
		}
	}

	print "Command \"$original\" not found\n";
	return 0;
}

1;
