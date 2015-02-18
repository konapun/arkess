package Arkess::IO::Terminal::Command::Loader;
#
# Load a command
#

use strict;
use File::List;
use File::Basename;

sub new {
	my $package = shift;
	return bless {}, $package;
}

sub loadDirectory {
	my ($self, $directory, @args) = @_;

  $directory = dirname(__FILE__) . "/$directory";
  die "Can't locate directory \"$directory\"" unless -d $directory;
	my @loaded;
	my $search = File::List->new($directory);
	my @files = @{$search->find("\.pm\$")};
	foreach my $file (@files) {
		push(@loaded, $self->load($file, @args));
	}

	return @loaded;
}

sub load {
	my ($self, $file, @loadArgs) = @_;

	require $file;
	my $module = ($file =~ /(.*)\.pm/)[0];
	$module =~ s/\//::/g;
	if ($module->can('execute')) {
		my $action = $module->new(@loadArgs);

		return $action;
	}
	return undef;
}

1;
