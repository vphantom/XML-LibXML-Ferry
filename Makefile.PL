use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'XML::LibXML::Ferry',
    AUTHOR           => q{Stephane Lavergne <https://github.com/vphantom/>},
    VERSION_FROM     => 'lib/XML/LibXML/Ferry.pm',
    ABSTRACT_FROM    => 'lib/XML/LibXML/Ferry.pm',
    LICENSE          => 'mit',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        #'ABC'              => '1.6',
        #'Foo::Bar::Module' => '5.0401',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'XML-LibXML-Ferry-*' },
);
