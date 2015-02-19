package Arkess::IO::Terminal::Command;
#
# A command is a Blocky::Character::Action with its options
#

use strict;
use Arkess::IO::Terminal::Command::Params;

sub new {
	my $package = shift;
	my ($name, @options) = @_;

	return bless {
		name   => $name,
		params => Arkess::IO::Terminal::Command::Params->new(@options),
	}, $package;
}

sub getName {
	return shift->{name};
}

sub getArguments {
	return shift->{params};
}

sub execute {
	my ($self, @options) = @_;

	$self->{action}->call($self->{params});
}

1;
