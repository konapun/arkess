package Arkess::IO::Terminal::Command;
#
# A command is an Arkess::Component::Actioned with its options
#

use strict;

sub new {
	my $package = shift;
	my ($name, @options) = @_;

	return bless {
		name   => $name,
		params => [@options],
	}, $package;
}

sub getName {
	return shift->{name};
}

sub getArguments {
	return @{shift->{params}};
}

sub execute {
	my ($self, @options) = @_;

	$self->{action}->call(@{$self->{params}});
}

1;
