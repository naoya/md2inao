package Text::Md2Inao::TestHelper;
use strict;
use warnings;

use Encode;
use Exporter::Lite;

our @EXPORT = qw/md2inao md2id/;

use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

sub md2inao {
    $Text::Md2Inao::Logger::STOP = 1;
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
    });
    $p->parse($_);
}

sub md2id {
    $Text::Md2Inao::Logger::STOP = 1;
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => Text::Md2Inao::Builder::InDesign->new,
    });
    $p->parse($_);
}

1;
