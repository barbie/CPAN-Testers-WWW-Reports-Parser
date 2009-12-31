package CPAN::Testers::WWW::Reports::Parser::YAML;

use 5.006;
use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.02';

#----------------------------------------------------------------------------
# Library Modules

use YAML::XS    qw(Load LoadFile);

#----------------------------------------------------------------------------
# Variables

#----------------------------------------------------------------------------
# The Application Programming Interface

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub DESTROY {
    my $self = shift;
}

# full data set methods

sub register {
    my $self = shift;
    my %hash = @_;
    $self->{file} = $hash{file};
    $self->{data} = $hash{data};
}

sub raw_data {
    my $self = shift;
    return Load($self->{data})  if($self->{data});
    return LoadFile($self->{file});
}

q{ Kein Zurück für dich };

__END__

=head1 NAME

CPAN::Testers::WWW::Reports::Parser::YAML - CPAN Testers YAML parser

=head1 SYNOPSIS

  use CPAN::Testers::WWW::Reports::Parser::YAML;

  my $obj = CPAN::Testers::WWW::Reports::Parser::YAML->new();

  $obj->register( file => $file );  # local file name
  $obj->register( data => $data );  # reference to a data block

  my $data = $obj->raw_data();

=head1 DESCRIPTION

This distribution is used to extract the data from a YAML file containing
metadata regarding reports submitted by CPAN Testers, and available from the 
CPAN Testers website.

=head1 INTERFACE

=head2 The Constructor

=over

=item * new

Instatiates the object.

=back

=head2 Public Methods

=over

=item * register

=item * raw_data

=back

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties, that is not explained within the POD
documentation, please send bug reports and patches to the RT Queue (see below).

Fixes are dependant upon their severity and my availablity. Should a fix not
be forthcoming, please feel free to (politely) remind me.

RT: http://rt.cpan.org/Public/Dist/Display.html?Name=CPAN-Testers-WWW-Reports-Parser

=head1 SEE ALSO

F<http://www.cpantesters.org/>,
F<http://stats.cpantesters.org/>,
F<http://wiki.cpantesters.org/>,
F<http://blog.cpantesters.org/>

=head1 AUTHOR

  Barbie <barbie@cpan.org> 2009-present

=head1 COPYRIGHT AND LICENSE

  Copyright (C) 2009-2010 Barbie <barbie@cpan.org>

  This module is free software; you can redistribute it and/or
  modify it under the same terms as Perl itself.

=cut
