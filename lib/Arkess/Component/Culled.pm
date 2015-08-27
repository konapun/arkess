package Arkess::Component::Culled;

use strict;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::2D',
    'Arkess::Component::Renderable',
    'Arkess::Component::Image'
  ];
}

sub setPriority {
  return 1;
}

sub initialize {
  my ($self, $rects, $image) = @_; # rects is a map of z-indexes to rectanges occupying that index

  $self->{image} = $image;
  $self->{rects} = $rects;
  $self->{clipped} = [];
}

sub finalize {
  my ($self, $cob) = @_;

  $self->{image} ||= $cob->getImageSurface();
  $self->_updateCullingRectangles($cob);
}

sub exportMethods {
  my $self = shift;

  return {

    addCullingRectangle => sub {
      my ($cob, $rect) = @_;

      while (my ($zIndex, $rects) = each %$rect) {
        $self->{rects}->{$zIndex} = $rects;
      }
      $self->_updateCullingRectangles($cob);
    },

    render => sub {
      print "Rendering\n";
      foreach my $image (@{$self->{clipped}}) {
        $image->render();
      }
    }

  };
}

sub _updateCullingRectangles {
  my ($self, $cob) = @_;

  my $clipped = [];
  foreach my $zIndex (keys %{$self->{rects}}) {
    my $rects = $self->{rects}->{$zIndex};

use Data::Dumper;
print Dumper($rects);
    foreach my $rect (@$rects) {
print "RECT:\n";
print Dumper($rect);
      my $image = Arkess::Object->new({
        'Arkess::Component::Image' => $cob->getImageSource()
      });

print  "Setting zindex to $zIndex\n";
      $image->setZIndex($zIndex);
      $image->setImageClipping($rect);
      $image->setRenderer($cob->getRenderer());
      push(@$clipped, $image);
    }
  }
  $self->{clipped} = $clipped;
}

1;
