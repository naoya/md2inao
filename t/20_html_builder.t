use utf8;

use strict;
use warnings;
use Test::More;

use Text::Md2Inao;
use Text::Md2Inao::Builder::Html;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
    builder                => Text::Md2Inao::Builder::Html->new,
});

my $out = $p->parse(<<EOF);
hogehoge
EOF

is $out, '<p>hogehoge</p>';

done_testing;
