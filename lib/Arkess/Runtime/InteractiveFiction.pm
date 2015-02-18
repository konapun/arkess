package Arkess::Runtime::InteractiveFiction;

use strict;
use Arkess::IO::Terminal;
use base qw(Arkess::Runtime::Base);

sub new {
    my $package = shift;

    return bless {
      entities => [], # FIXME use object instead for easy removes
      running  => 0,
      eventBus => Arkess::Event::Bus->new(),
      eventHub => Arkess::IO::Controller::Hub->new(),
      terminal => Arkess::IO::Terminal->new()
    }, $package;
}

sub run {
	my $self = shift;

  my $term = $self->{terminal};
  my $eventBus = $self->{eventBus};
  my $eventHub = $self->{eventHub};
	$self->{running} = 1;
	while ($self->{running}) {
    $eventBus->trigger(Arkess::Event::LOOP_START);
		my $input = $term->prompt();
		$term->process($input);
    $eventHub->processEvents();
    $eventBus->trigger(Arkess::Event::BEFORE_RENDER);
    $eventBus->trigger(Arkess::Event::AFTER_RENDER);
	}
  $eventBus->trigger(Arkess::Event::RUNTIME_STOP);
}

1;
