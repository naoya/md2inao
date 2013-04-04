use utf8;
use strict;
use warnings;
use Test::More;

use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

my $builder = Text::Md2Inao::Builder::InDesign->new;

$builder->before_filter_config({
    'test' => "テスト"
});

$builder->after_filter_config({
    "★" => "<CharStyle:赤字>★<CharStyle:>"
});

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
    builder                => $builder,
});

my $in = <<EOF;
★test★
EOF

is $p->parse($in), <<EOF;
<ParaStyle:本文><CharStyle:赤字>★<CharStyle:>テスト<CharStyle:赤字>★<CharStyle:>
EOF

done_testing;
