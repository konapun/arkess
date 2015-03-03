package Arkess::IO::Terminal;
#
# A terminal which will act as the controller
#

use strict;
use Arkess::IO::Terminal::Command;
use Arkess::IO::Terminal::Command::Loader; # load the builtins
use Arkess::IO::Terminal::UI;
use Arkess::IO::Terminal::Event;
use Arkess::Event::Bus;
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
	$self->{eventBus}    = Arkess::Event::Bus->new(); # event system for registering plugins

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

sub loadPlugin {
	my ($self, $plugin) = @_; # plugins are lowercase versions of their package names relative to the Arkess/IO/Terminal/Plugin directory

	$plugin = 'Arkess::IO::Terminal::Plugin::' .  $plugin;
	eval "require $plugin";
  my $instance = $plugin->new($self);
	$instance->register($self);
}

sub getEventBus {
	return shift->{eventBus};
}

#OVERRIDE
sub process {
	my ($self, $string) = @_;

	my $eventBus = $self->{eventBus};
	my @cmd = split(/\s+/, $string);
	my $commandWord = shift @cmd;
	my $command = Arkess::IO::Terminal::Command->new($commandWord, @cmd);

	my $ret;
	$ret = $self->_processBuiltins($command);
	$eventBus->trigger(Arkess::IO::Terminal::Event::COMMAND_SUCCEEDED, $command) && return $ret if defined $ret;
	$ret = $self->_processBindings($command);
	$eventBus->trigger(Arkess::IO::Terminal::Event::COMMAND_SUCCEEDED, $command) && return $ret if defined $ret;

	$eventBus->trigger(Arkess::IO::Terminal::Event::COMMAND_FAILED, $command);
	return 0; # Failed
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
		$self->bind($bindingName, sub {
			$self->getPlayer()->callAction($bindingName, @_);
		});
	}
}

sub _init {
	my $self = shift;

	# Load commands
	my $loader = Arkess::IO::Terminal::Command::Loader->new();
	my @commands = $loader->loadDirectory($self->{builtinsDir}, $self);
	$self->{builtins} = [@commands];

	# Load plugins
#	foreach my $plugin (('autocomplete', 'exitStatus')) {
#		$self->loadPlugin($plugin);
#	}
}

sub _processBuiltins {
	my ($self, $command) = @_;

	my $commandWord = $command->getName();
	foreach my $builtin (@{$self->{builtins}}) {
		if ($commandWord eq $builtin->registersAs()) {
			return $builtin->execute($command->getArguments());
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
			return $bindings{$key}->($command->getArguments());
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
