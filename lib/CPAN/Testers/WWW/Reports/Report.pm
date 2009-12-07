package CPAN::Testers::WWW::Reports::Report;

use strict;
use warnings;
use Carp;
our $AUTOLOAD;

my @methods = (
    "ostext",       "osvers",   "perl",        "platform",
    "version",      "csspatch", "distversion", "id",
    "status",       "state",    "cssperl",     "dist",
    "distribution", "osname",
);
my %permitted_methods = map { $_ => 1 } @methods;

sub new {
    my ( $class, $self ) = @_;

    bless $self, 'CPAN::Testers::WWW::Reports::Report';

    $self->{_permitted} = \%permitted_methods;

    return $self;
}

sub DESTROY {
}

sub AUTOLOAD {
    my $self = shift;
    my $type = ref($self)
        or croak "$self is not an object";

    my $name = $AUTOLOAD;
    $name =~ s/.*://;    # strip fully-qualified portion

    unless ( exists $self->{_permitted}->{$name} ) {
        croak "Can't access `$name' field in class $type";
    }

    if (@_) {
        return $self->{$name} = shift;
    } else {
        return $self->{$name};
    }
}

1;

__DATA__

=head1 NAME

CPAN::Testers::WWW::Reports::Report

=head1 SYNOPSIS

  use CPAN::Testers::WWW::Reports::Parser;

  my $obj = CPAN::Testers::WWW::Reports::Parser->new(
        format => 'YAML',   # or 'JSON'
        file   => $file     # or data => $data
        report_objects => 1, # Optional, works with $obj->report()
  );

  # iterator, accessing aternate field names
  while( my $report = $obj->report() ) {
  
      $report->csspatch(); 
      $report->cssperl();
      $report->dist();
      $report->distribution(); 
      $report->distversion(); 
      $report->id();
      $report->osname();
      $report->ostext();       
      $report->osvers();
      $report->perl();        
      $report->platform();
      $report->state();    
      $report->status();     
      $report->version();      
  }
  
=cut






