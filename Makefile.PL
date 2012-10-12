if (-e 'dropbox-api') {
    print STDERR "Generating bin/dropbox-api from dropbox-api\n";
    mkdir 'bin' unless -d 'bin';
    open my $in,  "<dropbox-api"     or die $!;
    open my $out, ">bin/dropbox-api" or die $!;
    while (<$in>) {
        s|^#!/usr/bin/env perl|#!perl|; # so MakeMaker can fix it
        print $out $_
    }
}
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'App::dropboxapi',
    VERSION_FROM => 'lib/App/dropboxapi.pm',
    ABSTRACT => 'Dropbox API Wrapper Command.',
    PREREQ_PM => {
        'ExtUtils::MakeMaker' => 6.30,
        'ExtUtils::Install' => 1.43,
        'JSON' => 0,
        'Path::Class' => 0,
        'WebService::Dropbox' => 0,
        'DateTime::Format::Strptime' => 0,
        'Encode::Locale' => 0,
        ($^O eq 'darwin' ? ('Encode::UTF8Mac' => 0) : ()),
    },
    LICENSE => 'perl',
    EXE_FILES => [ 'bin/dropbox-api' ],
);