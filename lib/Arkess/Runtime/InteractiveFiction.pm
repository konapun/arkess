package Arkess::Runtime::InteractiveFiction;

use strict;
use Arkess::IO::Terminal;
use base qw(Arkess::Runtime::Base);

sub new {
    my $package = shift;

    my $self = bless {
      entities => [], # FIXME use object instead for easy removes
      running  => 0,
      eventBus => Arkess::Event::Bus->new(),
      eventHub => Arkess::IO::Controller::Hub->new(),
      terminal => Arkess::IO::Terminal->new(),
      setController => 0
    }, $package;
    $self->{terminal} = Arkess::IO::Terminal->new($self);
    return $self;
}

sub createController {
  my ($self, $player) = @_;

  die "Controller already set: InteractiveFiction runtime only allows a single controller" unless !$self->{setController};
  $self->{setController} = 1;
  $self->{terminal}->setPlayer($player);
  return $self->{terminal};
}

sub run {
	my $self = shift;

  my $term = $self->{terminal};
  my $eventBus = $self->{eventBus};
  my $eventHub = $self->{eventHub};
	$self->{running} = 1;
	while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::TICK);
		my $input = $term->prompt();
		$term->process($input);
    $eventHub->processEvents();
    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);
    $eventBus->trigger(Arkess::Event::AFTER_RENDER);
	}
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

1;
