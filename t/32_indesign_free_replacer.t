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

=== kbd
--- in md2inao
<kbd>F10</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>*<cFont:>

=== kbd
--- in md2inao
<kbd>F11</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>+<cFont:>

=== kbd
--- in md2inao
<kbd>F12</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>,<cFont:>

=== kbd
--- in md2inao
<kbd>F1</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>!<cFont:>

=== kbd
--- in md2inao
<kbd>F2</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>"<cFont:>

=== kbd
--- in md2inao
<kbd>F3</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>#<cFont:>

=== kbd
--- in md2inao
<kbd>F4</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>$<cFont:>

=== kbd
--- in md2inao
<kbd>F5</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>%<cFont:>

=== kbd
--- in md2inao
<kbd>F6</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>&<cFont:>

=== kbd
--- in md2inao
<kbd>F7</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>'<cFont:>

=== kbd
--- in md2inao
<kbd>F8</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>(<cFont:>

=== kbd
--- in md2inao
<kbd>F9</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>)<cFont:>

=== kbd
--- in md2inao
<kbd>→</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>z<cFont:>

=== kbd
--- in md2inao
<kbd>↓</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>|<cFont:>

=== kbd
--- in md2inao
<kbd>↑</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>{<cFont:>

=== kbd
--- in md2inao
<kbd>←</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>y<cFont:>

=== kbd
--- in md2inao
<kbd>End</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>n<cFont:>

=== kbd
--- in md2inao
<kbd>Alt</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>m<cFont:>

=== kbd
--- in md2inao
<kbd>Ctrl</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>l<cFont:>

=== kbd
--- in md2inao
<kbd>Control</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>l<cFont:>

=== kbd
--- in md2inao
<kbd>Shift</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>`<cFont:>

=== kbd
--- in md2inao
<kbd>Tab</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>k<cFont:>

=== kbd
--- in md2inao
<kbd>Esc</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>j<cFont:>

=== kbd
--- in md2inao
<kbd>Delete</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>g<cFont:>

=== kbd
--- in md2inao
<kbd>Insert</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>f<cFont:>

=== kbd
--- in md2inao
<kbd>Pause</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>s<cFont:>

=== kbd
--- in md2inao
<kbd>Break</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>e<cFont:>

=== kbd
--- in md2inao
<kbd>Home</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>o<cFont:>

=== kbd
--- in md2inao
<kbd>Back Space</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>p<cFont:>

=== kbd
--- in md2inao
<kbd>Space</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>d<cFont:>

=== kbd
--- in md2inao
<kbd>Pgup</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>c<cFont:>

=== kbd
--- in md2inao
<kbd>Pgdn</kbd>
--- expected
<ParaStyle:本文><cFont:Key Snd Mother>b<cFont:>

=== kbd
--- in md2inao
<kbd>Enter</kbd>
--- expected
<ParaStyle:本文><cFont:Key Mother><00A9><cFont:>

=== kbd
--- in md2inao
<kbd><</kbd>
--- expected
<ParaStyle:本文><cFont:Key Mother><005C><<cFont:>

=== kbd
--- in md2inao
<kbd>></kbd>
--- expected
<ParaStyle:本文><cFont:Key Mother><005C>><cFont:>

===
--- in md2inao
◆WDB◆
--- expected
<ParaStyle:本文><cstyle:ストッパ>#<cstyle:>

=== sup
--- in md2inao
<sup>上付き（ゴシック、コラムなどでの注記用）</sup>
--- expected
<ParaStyle:本文><CharStyle:上付き>上付き（ゴシック、コラムなどでの注記用）<CharStyle:>

=== sup
--- in md2inao
<sup2>上付き（その場のフォントで上付き）</sup2>
--- expected
<ParaStyle:本文><cp:Superscript>上付き（その場のフォントで上付き）<cp:>

=== red
--- in md2inao
★
--- expected
<ParaStyle:本文><CharStyle:赤字>★<CharStyle:>

=== red
--- in md2inao
☆
--- expected
<ParaStyle:本文><CharStyle:赤字>☆<CharStyle:>

=== red
--- in md2inao
▲
--- expected
<ParaStyle:本文><CharStyle:赤字>▲<CharStyle:>

=== red
--- in md2inao
□
--- expected
<ParaStyle:本文><CharStyle:赤字>□<CharStyle:>

=== 
--- in md2inao
㈱(株)
--- expected
<ParaStyle:本文><3231><3231>

=== 
--- in md2inao
✓
--- expected
<ParaStyle:本文><ct:Regular><cf:Zapf Dingbats><2713><ct:><cf:>

=== shiftjis
--- in md2inao
✖
--- expected
<ParaStyle:本文><ct:Regular><cf:Zapf Dingbats><2716><ct:><cf:>

=== shiftjis
--- in md2inao
\
--- expected
<ParaStyle:本文><005C><005C>

=== shiftjis
--- in md2inao
~
--- expected
<ParaStyle:本文><007E>

=== shiftjis
--- in md2inao
～
--- expected
<ParaStyle:本文>〜
