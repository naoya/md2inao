use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
    NAME => 'Text::Md2Inao',
    AUTHOR => ['@naoya_ito', '@__gfx__'],
    ABSTRACT_FROM => 'lib/Text/Md2Inao.pm',
    VERSION_FROM => 'lib/Text/Md2Inao.pm',
    LICENSE => 'perl',

    EXE_FILES => [qw(bin/md2inao.pl)],

    META_MERGE => {
        resources => {
            repository => 'https://github.com/naoya/md2inao.git',
        },
    },
);
