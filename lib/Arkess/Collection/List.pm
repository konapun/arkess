package Arkess::Collection::List;

use strict;

sub new {
	my $package = shift;
	my $items = shift;
	
	my $length = 0; # keep track of length manually for O(1) instead of O(n) lookup
	if (defined $items) {
		$length = scalar(@$items);
	}
	return bless {
		items  => $items || [],
		length => $length,
	}, $package;
}

sub add {
	my ($self, $item) = @_;
	
	push(@{$self->{items}}, $item);
	$self->{length}++;
	return $item;
}

sub at {
	my ($self, $index) = @_;
	
	die "Index out of range" if $index < 0 || $index > $self->length()-1;
	return $self->{items}->[$index];
}

sub remove {
	my ($self, $item) = @_;
	
	my $index = 0;
	foreach my $contained (@{$self->{items}}) {
		if ($contained == $item) {
			my $ret = $self->removeAt($index);
			if (!defined $ret) {
				print "UNDEFINED!\n";
			}
			return $ret;
		}
		$index++;
	}
}

sub removeAt {
	my ($self, $index) = @_;
	
	die "Index out of range" if $index < 0 || $index > $self->length()-1;
	$self->{length}--;
	return splice(@{$self->{items}}, $index, 1);
}

sub clear {
	my $self = shift;
	
	$self->{items} = [];
	$self->{length} = 0;
}

sub length {
	return shift->{length};
}

sub all {
	return @{shift->{items}};
}

1;
