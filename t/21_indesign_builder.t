use utf8;

use strict;
use warnings;
use Test::More;

use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

my $builder = Text::Md2Inao::Builder::InDesign->new;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 53,
    builder                => $builder,
});

my $out = $p->parse(<<EOF);
# blah blah
hogehoge **piyo** hogehoge
EOF

is $out, <<EOF;
<SJIS-MAC>
<ParaStyle:大見出し>blah blah
<ParaStyle:本文>hogehoge <CharStyle:太字>piyo<CharStyle:>hogehoge
EOF

done_testing;
