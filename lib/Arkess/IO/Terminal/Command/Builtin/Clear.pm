package Arkess::IO::Terminal::Command::Builtin::Clear;
#
# Clear the screen
#

use strict;

sub new {
	my $package = shift;
	my $shell = shift;

	return bless {
		shell => $shell,
		lines => 60,
	}, $package;
}

sub registersAs {
	return 'clear';
}

sub execute {
	my $self = shift;

	print "\n" x $self->{lines}; # FIXME - should use curses or something not so lame
	return 1;
}

1;
