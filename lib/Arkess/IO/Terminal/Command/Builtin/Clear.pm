package Arkess::IO::Terminal::Command::Builtin::Clear;
#
# Clear the screen
#

use strict;
use base qw(Arkess::IO::Terminal::Command::Builtin);

sub new {
	my $package = shift;

	my $self = $package->SUPER::new(@_);
	$self->{lines} = 60;
	return $self;
}

sub registersAs {
	return 'clear';
}

sub execute {
	my $self = shift;

	print "\n" x $self->{lines}; # FIXME - should use curses or something not so lame
	return 1;
}

sub getDescription {
	return "Clears the screen";
}

1;
