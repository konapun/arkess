package Arkess::Collection::Hash;

use strict;

sub new {
	my $package = shift;
	my $items = shift; # a hash
	
	return bless {
		items => $items || {},
	}, $package;
}

sub has {
	my ($self, $key) = @_;
	
	return defined $self->{items}->{$key};
}

sub set {
	my ($self, $key, $value) = @_;
	
	$self->{items}->{$key} = $value;
}

sub get {
	my ($self, $key) = @_;
	
	die "No such key \"$key\"" unless $self->has($key);
	return $self->{items}->{$key};
}

sub keys {
	my $self = shift;
	
	return keys %{$self->{items}};
}

sub values {
	my $self = shift;
	
	return values %{$self->{items}};
}

sub list {
	return shift->{items};
}

sub remove {
	my ($self, $key) = @_;
	
	die "No such key \"$key\"" unless $self->has($key);
	return delete $self->{items}->{$key};
}

sub clear {
	shift->{items} = {};
}

# Allow block setting
sub configure {
	my ($self, $hashref) = @_;
	
	while (my ($key, $val) = each(%$hashref)) {
		$self->set($key, $val);
	}
}

1;
