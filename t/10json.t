#!/usr/bin/perl -w
use strict;
use Test::More;
use CPAN::Testers::WWW::Reports::Parser;
use Data::Dumper;

eval "use JSON::XS";
plan skip_all => "JSON::XS required for testing JSON parser" if $@;
plan tests => 33;

my $count           = 100;
my $report_original = {
    'ostext'       => 'Linux',
    'version'      => '0.12',
    'status'       => 'PASS',
    'dist'         => undef,
    'osvers'       => '2.6.27.19-5-default',
    'csspatch'     => 'unp',
    'state'        => 'pass',
    'distribution' => 'App-Maisha',
    'perl'         => '5.10.0',
    'distversion'  => 'App-Maisha-0.12',
    'cssperl'      => 'rel',
    'osname'       => 'linux',
    'platform'     => 's390x-linux',
    'id'           => '3702934'
};
my $report_filtered = {
    'version'  => '0.12',
    'grade'    => 'PASS',
    'distname' => 'App-Maisha'
};
my $report_extended = {
    'ostext'       => 'Linux',
    'version'      => '0.12',
    'status'       => 'PASS',
    'grade'        => 'PASS',
    'dist'         => undef,
    'osvers'       => '2.6.27.19-5-default',
    'csspatch'     => 'unp',
    'state'        => 'pass',
    'distribution' => 'App-Maisha',
    'perl'         => '5.10.0',
    'distversion'  => 'App-Maisha-0.12',
    'cssperl'      => 'rel',
    'osname'       => 'linux',
    'platform'     => 's390x-linux',
    'id'           => '3702934',
    'distname'     => 'App-Maisha'
};
my @fields     = qw(distname version grade);
my @all_fields = qw(
    id distribution dist distname version distversion perl
    state status grade action osname ostext osvers platform
    archname url csspatch cssperl);

my $obj = CPAN::Testers::WWW::Reports::Parser->new(
    'format' => 'JSON',
    'file'   => './t/samples/App-Maisha.json'
);
isa_ok( $obj, 'CPAN::Testers::WWW::Reports::Parser' );

my $data = $obj->reports();

#diag(Dumper($data->[0]));
is( scalar(@$data), $count, '.. report count correct' );
is_deeply( $data->[0], $report_original, '.. matches original report' );

$data = $obj->reports(@fields);

#diag(Dumper($data->[0]));
is( scalar(@$data), $count, '.. report count correct' );
is_deeply( $data->[0], $report_filtered, '.. matches filtered report' );

$data = $obj->reports( 'ALL', @fields );

#diag(Dumper($data->[0]));
is( scalar(@$data), $count, '.. report count correct' );
is_deeply( $data->[0], $report_extended, '.. matches extended report' );

$obj->filter();
$data = $obj->report();
is_deeply( $data, $report_original, '.. matches original report' );

$obj->{loaded} = 0;
$obj->filter(@fields);
$data = $obj->report();

#diag(Dumper($data));
is_deeply( $data, $report_filtered, '.. matches filtered report' );

$obj->{loaded} = 0;
$obj->filter( 'ALL', @fields );
$data = $obj->report();
is_deeply( $data, $report_extended, '.. matches extended report' );

$obj->{loaded} = 0;
$obj->filter();
my $reports = 0;
while ( $data = $obj->report() ) { $reports++ }
is( $reports, $count, '.. report count correct' );

{
    $obj->{loaded} = 0;
    $obj->filter(@all_fields);
    $data = $obj->report();

    no strict 'refs';
    for (
        qw(  id distribution dist distname version distversion perl
        state status grade action osname ostext osvers platform
        archname url csspatch cssperl )
        )
    {
        is( $obj->$_(), $data->{$_},
            ".. field '$_' matches direct and indirect access" );
    }
}

# Test object
my $obj_tester = CPAN::Testers::WWW::Reports::Parser->new(
    'format'         => 'JSON',
    'file'           => './t/samples/App-Maisha.json',
    'report_objects' => 1,
);
isa_ok( $obj_tester, 'CPAN::Testers::WWW::Reports::Parser' );

my $report_obj = $obj_tester->report();
isa_ok( $report_obj, 'CPAN::Testers::WWW::Reports::Report' );
is($report_obj->version, '0.12', 'Got a version as expected');











