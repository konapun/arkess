package Arkess::Component::TextBox;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::Widget' => {
      x => 6,
      y => 410,
      width => 500,
      height => 100,
      text => "TEXTBOX",
      color => 0x0EED000EA
    }
  };
}

sub initialize {
  my ($self, $textScreens) = @_;

  $textScreens = [] unless defined $textScreens;
  $self->{pages} = ref $textScreens eq 'ARRAY' ? $textScreens : [$textScreens];
  $self->{currentPage} = -1; # -1 because it will automatically be incremented to 0 on afterInstall
}

sub exportMethods {
  my $self = shift;

  return {

    displayNextPage => sub {
      my $cob = shift;

      if ($self->{currentPage} < scalar(@{$self->{pages}}-1)) {
        $self->{currentPage}++;
        $cob->writeText($cob->getTextboxText());
      }
      else {
        $cob->setVisibility(0);
        $cob = undef;
      }
    },

    displayPrevPage => sub {
      my $cob = shift;

      $self->{currentPage}-- unless $self->{currentPage} == 0;
    },

    getTextboxText => sub {
      return $self->{pages}->[$self->{currentPage}];
    }

  };
}

sub afterInstall {
  my ($self, $cob) = @_;

  $cob->displayNextPage();
}

1;
