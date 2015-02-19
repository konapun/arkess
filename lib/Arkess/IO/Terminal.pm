package Arkess::IO::Terminal;
#
# A terminal which will act as the controller
#

use strict;
use Arkess::IO::Terminal::Command;
use Arkess::IO::Terminal::Command::Loader; # load the builtins
use Arkess::IO::Terminal::UI;

use base qw(Arkess::IO::Controller);

sub new {
	my $package = shift;
	my ($env, $user) = @_;

	my $self = $package->SUPER::new($user->extend([ 'Arkess::Component::Actioned '])); # add actioned component for autobinds
	$self->{environment} = $env;
	$self->{ps1}         = '> ';
	$self->{builtinsDir} = 'Builtin'; # relative to Terminal/Command dir
	$self->{builtins}    = [];

	$self->_init();
	return $self;
}

sub setPS1 {
	my ($self, $ps1) = @_;

	$self->{ps1} = $ps1;
}

sub getPS1 {
  return shift->{ps1};
}

sub getPlayer {
	return shift->player();
}

sub getEnvironment {
	return shift->{environment};
}

#OVERRIDE
sub process {
	my ($self, $string) = @_;

	my @cmd = split(/\s+/, $string);
	my $commandWord = shift @cmd;
	my $command = Arkess::IO::Terminal::Command->new($commandWord, @cmd);

	my $ret;
	$ret = $self->_processBuiltins($command);
	return $ret if defined $ret;
	$ret = $self->_processBindings($command);
	return $ret if defined $ret;

	print "You can't do that!\n";
	return 0;
}

sub prompt {
	my $self = shift;

	print $self->{ps1};
	my $response = <STDIN>;
	chomp($response);
	return $response;
}

# Automatically create bindings for all user actions by their "registersAs" name
sub autobind {
	my $self = shift;

	my $actions = $self->getPlayer()->getActions(); # actions via Arkess::Component::Actioned
	foreach my $action (keys %$actions) {
		my $bindingName = $actions->{$action};

		$self->bindings()->set($bindingName, $action); # FIXME
	}
}

sub _init {
	my $self = shift;

	my $loader = Arkess::IO::Terminal::Command::Loader->new();
	my @commands = $loader->loadDirectory($self->{builtinsDir}, $self);
	$self->{builtins} = [@commands];
}

sub _processBuiltins {
	my ($self, $command) = @_;

	my $commandWord = $command->name();
	foreach my $builtin (@{$self->{builtins}}) {
		if ($commandWord eq $builtin->registersAs()) {
			return $builtin->execute($command->arguments());
		}
	}

	return undef;
}

sub _processBindings {
	my ($self, $command) = @_;

	my $commandWord = $command->name();
#	my %bindings = %{$self->bindings()->list()};
#	while (my ($key, $val) = each %bindings) {
#		if ($key eq $commandWord) {
#			return $val->call($command->arguments());
#		}
#	}

	return undef;
}

sub _processInventoryAcceptors { # actions defined on items
	my ($self, $command) = @_;

	foreach my $item ($self->player()->inventory()->all()) { #FIXME
		if ($item->attributes()->has('accepts')) {
			#TODO
		}
	}
}

1;
