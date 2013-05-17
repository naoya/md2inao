use utf8;

use Test::Base;
use Text::Md2Inao;
use Encode;
use Text::Md2Inao::Builder::InDesign;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    my $builder =Text::Md2Inao::Builder::InDesign->new;
    $builder->load_filter_config('./config/id_filter.json');
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => $builder,
    });
    my $out = $p->parse($_);
    $out =~ s/^<SJIS-MAC>\n//; # テストに毎回書くのめんどくさいので
    return $out;
}

__END__
=== kbd
--- in md2inao
<kbd>A</kbd>～<kbd>Z</kbd>
--- expected
<ParaStyle:本文><cFont:KeyMother>A<cFont:>～<cFont:KeyMother>Z<cFont:>

=== right arrow
--- in md2inao
<span class='symbol'>→</span>
--- expected
<ParaStyle:本文><cTypeface:R-KL><cFont:A-OTF リュウミン Pr5><27A1><cTypeface:><cFont:>

===
--- in md2inao
<span class='symbol'>←→</span>
--- expected
<ParaStyle:本文><21D4>

===
--- in md2inao
<span class='symbol'>＞＝</span><span class='symbol'>＝＞</span>
--- expected
<ParaStyle:本文><2267><2266>

===
--- in md2inao
<kbd>F10</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>*<cFont:>

===
--- in md2inao
<kbd>F1</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>!<cFont:>

===
--- in md2inao
<kbd>End</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>n<cFont:>

===
--- in md2inao
◆WDB◆
--- expected
<ParaStyle:本文><cstyle:ストッパ>#<cstyle:>

=== kbd
--- in md2inao
通常の本文<kbd>Enter</kbd>（←キーボードフォント）
--- expected
<ParaStyle:本文>通常の本文<cFont:Key Mother><00A9><cFont:>（←キーボードフォント）
