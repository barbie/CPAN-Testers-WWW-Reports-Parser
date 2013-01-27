#!/usr/bin/perl

use strict;
use warnings;
use 5.006;

use ExtUtils::MakeMaker;

print <<HERE;

  Please note that the tests within this distribution can take a long time
  to run. As such, be prepared to wait a little while to get the results.

HERE

WriteMakefile(
    AUTHOR              => 'Barbie <barbie@cpan.org>',
    NAME                => 'CPAN::Testers::WWW::Reports::Parser',
    VERSION_FROM        => 'lib/CPAN/Testers/WWW/Reports/Parser.pm',
    ABSTRACT            => 'CPAN Testers reports data parser',
    NO_META             => 1,

    PREREQ_PM           => {

        # prereqs
        'Carp'          => 0,

        # only one of the following is required.

        #'JSON::XS'     => 0,
        #'YAML::XS'     => 0,

        # build/test prereqs
        'IO::File'      => 0,
        'Test::More'    => '0.70',

    }
);
