package Arkess::IO::Terminal::Command::Params;
#
# Params passed to the controller binding
#

sub new {
	my $package = shift;
	my @params = @_;

	return bless {
		params => [@params],
	}, $package;
}

sub join {
	return join(' ', @{shift->{params}});
}

sub length {
	return scalar(@{shift->{params}});
}

sub all {
	return @{shift->{params}};
}

1;
