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

	$user = $user->extend([ 'Arkess::Component::Actioned ']) if defined $user;  # add actioned component for autobinds
	my $self = $package->SUPER::new($user);
	$self->{environment} = $env;
	$self->{ps1}         = '> ';
	$self->{bindings}    = {};
	$self->{builtinsDir} = 'Builtin'; # relative to Terminal/Command dir
	$self->{builtins}    = [];

	$self->_init();
	return $self;
}

sub setPlayer {
	my ($self, $user) = @_;

	$self->{user} = $user->extend([ 'Arkess::Component::Actioned' ]);
	$self->SUPER::setPlayer($user);
}

sub setPS1 {
	my ($self, $ps1) = @_;

	$self->{ps1} = $ps1;
}

sub getPS1 {
  return shift->{ps1};
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

#OVERRIDE
sub bind {
	my ($self, $key, $action) = @_;

	$self->{bindings}->{$key} = $action;
}

sub prompt {
	my $self = shift;

	print $self->{ps1};
	my $response = <STDIN>;
	chomp($response);
	return $response;
}

# Automatically create bindings for all actioned user operations
sub autobind {
	my $self = shift;

	my $actions = $self->getPlayer()->getActions(); # actions via Arkess::Component::Actioned
	foreach my $bindingName (keys %$actions) {
		my $action = $actions->{$bindingName};
		$self->bind($bindingName, $action);
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

	my $commandWord = $command->getName();
	foreach my $builtin (@{$self->{builtins}}) {
		if ($commandWord eq $builtin->registersAs()) {
			return $builtin->execute($command->arguments());
		}
	}

	return undef;
}

sub _processBindings {
	my ($self, $command) = @_;

	my $commandWord = $command->getName();
	my %bindings = %{$self->{bindings}};
	foreach my $key (keys %bindings) {
		if ($key eq $commandWord) {
			return $bindings{$key}->call($command->getArguments());
		}
	}

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
