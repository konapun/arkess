package AutumnDay::Item;

use strict;
use base qw(Arkess::Component);

sub requires {
  return {
    'Arkess::Component::EntityPositioned' => [],
    'Arkess::Component::Named' => "(unknown item)",
    'Arkess::Component::Describable' => "(no description)",
    'Arkess::Component::Item' => [],
    'Arkess::Component::Actioned' => [],
    'Arkess::Component::Usable' => sub { print "I don't know how to use that!" }
  };
}

# sub setPriority {
#   return 2;
# }
#
# sub beforeInstall {
#   my ($self, $cob) = @_;
#
#   my $oldSub = sub{};
#   if ($cob->hasAttribute('entityPositioned')) {
#     my $method = $cob->methods->get('getPosition');
#     $oldSub = sub {
#       my $val = $method->call();
#       print "Old: $val\n";
#       return $val;
#     };
#   }
#
#   $self->{getPosition} = $oldSub;
# }
#
# sub exportMethods {
#   my $self = shift;
#
#   return {
#
#     getPosition => sub {
#       my $cob = shift;
#
#       if ($cob->isBeingHeld()) {
#         print "Returning holder's position\n";
#         return $cob->getHolder()->getPosition();
#       }
#       else {
#         print "Returning own position\n";
#         return $self->{getPosition}->();
#       }
#     }
#
#   };
# }

1;
