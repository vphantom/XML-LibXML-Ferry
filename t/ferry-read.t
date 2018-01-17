#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;
use Test::Deep;

use XML::LibXML;
use XML::LibXML::Ferry;

use lib 't/';
use Test::FerryObject;

plan tests => 4;

my $doc = XML::LibXML->load_xml(location => 't/document.xml');
my $root = $doc->documentElement();


## XML::LibXML::Element::attr()
#

is(($root->attr())->{rootAttribute}, 'rootAttributeValue', 'Empty attr() returns attribute hash');


## XML::LibXML::Element::ferry()
#

sub _answer {
	my ($obj, $val) = @_;
	$val = $val->textContent if ref($val);
	return int($val) + 1;
}

my $hdoc = {
	url     => undef,
	emails  => [],
	color   => undef,
	tailles => [],
	answer  => undef,
	text    => undef,
	nono    => undef,
};
$root->ferry($hdoc, {
	FirstRoot => {
		firstRootAttribute1 => { 'nono' => 'nono' },
		Bizarre => [ 'answer', \&_answer ],
		# URL is implicit
	},
	Metas => {
		Meta => {
			__meta_name    => 'name',
			__meta_content => 'value',
			# email is implicit
		},
		Attribute => {
			__meta_name => 'type',
			size        => 'tailles',
			# color is implicit
		},
	},
	Depth => {
		Base => {
			Sub => {
				__meta_name => 'kind',
				'bar' => {
					SubOne => { __text => 'text' },  # CONVOLUTED: could be just 'text' but we want to test __text
				},
			},
		},
	},
});

cmp_deeply(
	$hdoc,
	{
		url => 'https://example.com/',
		emails => [
			'foo1@example.com',
			'foo2@example.com',
			'foo3@example.com',
		],
		color => 'Blue',
		tailles => [
			'Small',
		],
		answer => 42,
		text   => 'TestSubOne2',
		nono   => undef,
	},
	'Ferry to hash flattens'
);

my $rootObj = Test::FerryObject->new();
$root->ferry($rootObj, {
	FirstRoot => {
		# URL is implicit
	},
	Metas => {
		Meta => {
			__meta_name    => 'name',
			__meta_content => 'value',
			# email is implicit
		},
	},
	Depth => {
		Base => {
			Sub => [ 'nest', 'Test::FerryObject2' ],
		},
	},
});

isa_ok($rootObj->{_nest}, 'Test::FerryObject2', 'Ferry to object can nest');
cmp_deeply(
	$rootObj,
	noclass({
		_url   => 'https://example.com/',
		_email => 'foo3@example.com',
		_nest  => {
			_text  => 'TestSubTwo1',
		},
	}),
	'Ferry to object flattens'
);

