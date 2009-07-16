use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'              => 'CPAN::Testers::WWW::Reports::Parser',
    'VERSION_FROM'      => 'lib/CPAN/Testers/WWW/Reports/Parser.pm',
    'PREREQ_PM'         => {
        'Carp'              => 0,

        # only one of the following is required.

        #'JSON::XS'          => 0,
        #'YAML::XS'          => 0,
    },
    'NO_META'           => 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT	=> 'CPAN Testers reports data parser',
       AUTHOR	=> 'Barbie <barbie@cpan.org>') : ()),
);
