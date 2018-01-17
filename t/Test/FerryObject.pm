use 5.006;
use strict;
use warnings;

package Test::FerryObject;

sub new {
	my ($class, $el) = @_;
	my $self = {
		_url   => undef,
		_email => undef,
		_nest  => undef,
		_text  => undef,
	};
	bless $self, $class;

	if (defined $el) {
		$el->ferry($self, {
			__meta_name => 'kind',
			'foo' => {
				SubTwo => 'text',
			},
		});
		return undef unless defined $self->{_text};
	};
	return $self;
};

sub email {
	my ($self, $val) = @_;
	$self->{_email} = $val;
};

sub url {
	my ($self, $val) = @_;
	$self->{_url} = $val;
};

sub nest {
	my ($self, $val) = @_;
	$self->{_nest} = $val;
};

sub text {
	my ($self, $val) = @_;
	$self->{_text} = $val;
};

1;
