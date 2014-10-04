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

sub addEntity {
  my ($self, $entity) = @_;

  push(@{$self->{entities}}, $entity);
  $entity->setRenderer($self->{app});
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
sub render {
  my $self = shift;

  $self->_initializeEnvironment() unless defined $self->{app};
  foreach my $entity (@{$self->{entities}}) {
    $entity->render();
  }
  
}

# Destroy the window
sub DESTROY {
  my $self = shift;

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
