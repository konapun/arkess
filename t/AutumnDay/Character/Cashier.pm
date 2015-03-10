package AutumnDay::Character::Cashier;

use strict;
use Arkess::Object;

sub create {
  my $cashier = Arkess::Object->new([
    'Arkess::Component::Conversable',
    'AutumnDay::Character'
  ]);

  $cashier->whenTalkingTo('kid')->converse({
    greetings => ['Hello', 'Hey, there!'],
    questions => {
      "Hi, I'd like to buy these items" => sub {
        my $kid = shift;

        print "Alright, let me see what we have here...\n";
        if ($kid->hasInventoryItem('money')) {
          
        }
      },
      "What's your name?" => "Person",
      "Give me a random answer." => ["One", "Two", "Three", "Four", "Five"]
    }
  })
  return $cashier;
}

$cashier->whenTalkingTo('test')->converse({
  greetings => ['Hello', 'Hey, there!'],
  questions => {
    "Hi, I'd like to buy these items" => sub {

    },

  }
})->greet();

1;
