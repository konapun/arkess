package Arkess::Component::GIF;

use strict;
use Arkess::Object;
use Image::ParseGIF;
use base qw(Arkess::Component);

sub requires {
  return [
    'Arkess::Component::Renderable',
    'Arkess::Component::Positioned',
    'Arkess::Component::2D'
  ];
}

sub initialize {
  my ($self, $src, $opts) = @_;

  my $gif = Image::ParseGIF->new($src) or die "Can't parse gif from '$src'";
  my @images;
  foreach my $frame ($gif->parts()) {
    push(@images, Arkess::Object->new({
      'Arkess::Component::Image' => $frame
    }));
  }
  print "GOT " . scalar(@images) . " FRAMES\n";

}

sub exportMethods {
  my $self = shift;

  return {

    render => sub {
      my $cob = shift;
      my $renderer = $cob->getRenderer();


    }

  };
}
