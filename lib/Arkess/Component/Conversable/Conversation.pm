package Arkess::Component::Conversable::Conversation;

use strict;
use Scalar::Util::Numeric qw(isint);
use Arkess::Component::Conversable::Autowrap;

sub new {
  my $package = shift;
  my ($participant1, $participant2) = @_;

  return bless {
    participant1 => $participant1,
    participant2 => $participant2,
    greetings => [],
    goodbyes  => [],
    questions => {},
    conversationLevel => 0,
    ps1 => '>> '
  }, $package;
}

sub converse {
  my ($self, $hash) = @_;

  $self->_parseQuestions($hash->{questions});
  $self->{greetings} = $hash->{greetings} || [];
  $self->{goodbyes} = $hash->{goodbyes} || [];
}

sub begin {
  my ($self, $player) = @_;

  my @questions = keys %{$self->{questions}};
  if ($self->{greetings}) {
    print $self->{participant1}->getName() . ': ' . $self->_getRandomGreeting() . "\n";
  }
  $self->_printQuestions(@questions);
  $self->_promptForResponse($player, @questions);
}

sub _parseQuestions {
  my ($self, $hash) = @_;

  while (my ($key, $val) = each %$hash) {
    my $wrapped = Arkess::Component::Conversable::Autowrap->new($val);
    $self->{questions}->{$key} = $wrapped;
  }
}

sub _getRandomGreeting {
  my $self = shift;

  return $self->{greetings}->[rand int(scalar(@{$self->{greetings}}))];
}

sub _getRandomGoodbye {
  my $self = shift;

  return $self->{goodbyes}->[rand int(scalar(@{$self->{goodbyes}}))];
}

sub _printQuestions {
  my ($self, @questions) = @_;

  my $index = 1;
  foreach my $question (@questions) {
    print "\t($index. $question)\n";
    $index++;
  }
  print "\t($index. Bye.)\n";
}

sub _promptForResponse {
  my ($self, $player, @responses) = @_;

  my $response;
  my $name = $self->{participant1}->getName();
  while (1) {
    print $self->{ps1};
    my $response = <STDIN>;
    chomp($response);
    my $max = scalar(@responses)+1;
    while (!isint($response) || ($response < 0 || $response > $max)) {
      print "Please enter a number between 1 and $max\n";
      print $self->{ps1};
      $response = <STDIN>;
      chomp($response);
    }

    if (int($response) == scalar(@responses)+1) {
      print "$player: Bye.\n";
      print "$name: " . $self->_getRandomGoodbye() . "\n";
      return;
    }
    my $key = $responses[int($response)-1];
    my $answer = $self->{questions}->{$key}->execute();
    print "$player: $key\n";
    if (ref $answer eq 'HASH') {
      use Data::Dumper;
      print Dumper($answer);
      $self->_promptForResponse($player, $answer);
    }
    print "$name: $answer\n";
  }
}

sub _respondTo {
  my ($self, $question, $context) = @_;

}

1;

__END__
=head1 NAME
Arkess::Component::Conversable::Conversation - A two-person conversation
