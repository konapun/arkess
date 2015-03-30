package Arkess::IO::Renderer;

use strict;
use SDLx::App;

sub new {
  my $package = shift;
  my $appArgs = shift;

  my $self = bless {
    app      => undef,
    appArgs  => {},
    entities => []
  }, $package;

  $self->setWindowOptions($appArgs);
  return $self;
}

sub register {
  my ($self, $entity) = @_;

  # TODO: Sort entities by zlayer
  push(@{$self->{entities}}, $entity);
  $entity->setRenderer($self->{app});
}

sub unregister {
  my ($self, $entity) = @_;

  my $index = 0;
  foreach my $contained (@{$self->{entities}}) {
    if ($contained eq $entity) {
      splice(@{$self->{entities}}, $index, 1);
      return 1;
    }
    $index++;
  }
  return 0;
}

sub initialize {
  shift->_initializeEnvironment();
}

sub setWindowOptions {
  my ($self, $appArgs) = @_;

  $appArgs->{title} ||= 'Arkess';
  $appArgs->{width} ||= 600;
  $appArgs->{height} ||= 600;
  $self->{appArgs} = $appArgs;
}

sub getWindowOptions {
  return shift->{appArgs};
}

sub render {
  my $self = shift;

  $self->_initializeEnvironment() unless defined $self->{app};
  my @zOrdered = sort { $a->getZIndex() <=> $b->getZIndex() } @{$self->{entities}};
  foreach my $entity (@zOrdered) {
    $entity->render();
  }
  $self->{app}->update();
}

sub DESTROY {
  my $self = shift;

  # TODO: Mr. Gorbachev, tear down this window!
}

# Create the window
sub _initializeEnvironment {
  my $self = shift;

  my $args = $self->{appArgs};
  $args->{exit_on_quit} = 1; # Don't allow this to be overridden
  my $app = SDLx::App->new(%{$args});
  $self->{app} = $app;

  foreach my $entity (@{$self->{entities}}) {
    $entity->setRenderer($app);
  }
}

1;

__END__
=head1 NAME
Arkess::IO::Renderer - Create the graphical environment and invoke `render()` on
all renderable entities registered with the renderer
