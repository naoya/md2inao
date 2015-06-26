use 5.10.0;
use strict;
use warnings;
use utf8;

use Test::Base;
use Text::Md2Inao;
use Encode;
use Text::Md2Inao::Builder::InDesign;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    state $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => Text::Md2Inao::Builder::InDesign->new,
    });
    my $out = $p->parse($_);
    $out =~ s/^<SJIS-MAC>\n//; # テストに毎回書くのめんどくさいので
    return $out;
}

__END__
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
```
my_app
├── lib
│   ├── MyApp
│   │   └── Controller
│   │       └── Example.pm
│   └── MyApp.pm
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>my_app
<ParaStyle:リスト>├── lib
<ParaStyle:リスト>│   ├── MyApp
<ParaStyle:リスト>│   │   └── Controller
<ParaStyle:リスト>│   │       └── Example.pm
<ParaStyle:リスト>│   └── MyApp.pm

=== fullwidth tilde to wave dash
--- in md2inao
～
--- expected
<ParaStyle:本文><301C>

=== fullwidth tilde to wave dash
--- in md2inao
(株)(有)(社)(名)(特)(財)(学)(監)(資)(協)㈱㈲㈳㈴㈵㈶㈻㈼㈾㈿
--- expected
<ParaStyle:本文><3231><3232><3233><3234><3235><3236><323B><323C><323E><323F><3231><3232><3233><3234><3235><3236><323B><323C><323E><323F>

=== copyright
--- in md2inao
©(C)
--- expected
<ParaStyle:本文><00A9><00A9>
