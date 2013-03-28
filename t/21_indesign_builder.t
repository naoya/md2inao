use utf8;

use strict;
use warnings;
use Test::More;

use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
    builder                => Text::Md2Inao::Builder::InDesign->new,
});

my $out = $p->parse(<<EOF);
# blah blah
hogehoge
EOF

is $out, <<EOF;
<ParaStyle:大見出し>blah blah
<ParaStyle:本文>hogehoge
EOF

done_testing;
