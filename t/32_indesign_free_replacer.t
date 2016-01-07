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

=== roman number 
--- in md2inao
Ⅰ

ⅰ

Ⅱ

ⅱ

Ⅲ

ⅲ

Ⅳ

ⅳ

Ⅴ

ⅴ

Ⅵ

ⅵ

Ⅶ

ⅶ

Ⅷ

ⅷ

Ⅸ

ⅸ

Ⅹ

ⅹ
--- expected
<ParaStyle:本文><2160>
<ParaStyle:本文><2170>
<ParaStyle:本文><2161>
<ParaStyle:本文><2171>
<ParaStyle:本文><2162>
<ParaStyle:本文><2172>
<ParaStyle:本文><2163>
<ParaStyle:本文><2173>
<ParaStyle:本文><2164>
<ParaStyle:本文><2174>
<ParaStyle:本文><2165>
<ParaStyle:本文><2175>
<ParaStyle:本文><2166>
<ParaStyle:本文><2176>
<ParaStyle:本文><2167>
<ParaStyle:本文><2177>
<ParaStyle:本文><2168>
<ParaStyle:本文><2178>
<ParaStyle:本文><2169>
<ParaStyle:本文><2179>

=== fullwidth hyphen-minus
--- in md2inao
－
--- expected
<ParaStyle:本文><FF0D>

=== latin-alphabet
--- in md2inao
Á

É

Í

Ó

Ú

Ý

À

È

Ì

Ò

Ù

Â

Ê

Î

Ô

Û

Ä

Ë

Ï

Ö

Ü

Ÿ

á

é

í

ó

ú

ý

à

è

ì

ò

ù

â

ê

î

ô

û

ä

ë

ï

ö

ü

ÿ

Ç

Ş

Ã

Õ

Ñ

Ą

Ę

Į

Ų

Æ

Œ

Ø

Ĳ

Þ

ç

ş

ã

õ

ñ

ą

ę

į

ų

æ

œ

ø

ĳ

ß

þ
--- expected
<ParaStyle:本文><00C1>
<ParaStyle:本文><00C9>
<ParaStyle:本文><00CD>
<ParaStyle:本文><00D3>
<ParaStyle:本文><00DA>
<ParaStyle:本文><00DD>
<ParaStyle:本文><00C0>
<ParaStyle:本文><00C8>
<ParaStyle:本文><00CC>
<ParaStyle:本文><00D2>
<ParaStyle:本文><00D9>
<ParaStyle:本文><00C2>
<ParaStyle:本文><00CA>
<ParaStyle:本文><00CE>
<ParaStyle:本文><00D4>
<ParaStyle:本文><00DB>
<ParaStyle:本文><00C4>
<ParaStyle:本文><00CB>
<ParaStyle:本文><00CF>
<ParaStyle:本文><00D6>
<ParaStyle:本文><00DC>
<ParaStyle:本文><0178>
<ParaStyle:本文><00E1>
<ParaStyle:本文><00E9>
<ParaStyle:本文><00ED>
<ParaStyle:本文><00F3>
<ParaStyle:本文><00FA>
<ParaStyle:本文><00FD>
<ParaStyle:本文><00E0>
<ParaStyle:本文><00E8>
<ParaStyle:本文><00EC>
<ParaStyle:本文><00F2>
<ParaStyle:本文><00F9>
<ParaStyle:本文><00E2>
<ParaStyle:本文><00EA>
<ParaStyle:本文><00EE>
<ParaStyle:本文><00F4>
<ParaStyle:本文><00FB>
<ParaStyle:本文><00E4>
<ParaStyle:本文><00EB>
<ParaStyle:本文><00EF>
<ParaStyle:本文><00F6>
<ParaStyle:本文><00FC>
<ParaStyle:本文><00FF>
<ParaStyle:本文><00C7>
<ParaStyle:本文><015E>
<ParaStyle:本文><00C3>
<ParaStyle:本文><00D5>
<ParaStyle:本文><00D1>
<ParaStyle:本文><0104>
<ParaStyle:本文><0118>
<ParaStyle:本文><012E>
<ParaStyle:本文><0172>
<ParaStyle:本文><00C6>
<ParaStyle:本文><0152>
<ParaStyle:本文><00D8>
<ParaStyle:本文><0132>
<ParaStyle:本文><00DE>
<ParaStyle:本文><00E7>
<ParaStyle:本文><015F>
<ParaStyle:本文><00E3>
<ParaStyle:本文><00F5>
<ParaStyle:本文><00F1>
<ParaStyle:本文><0105>
<ParaStyle:本文><0119>
<ParaStyle:本文><012F>
<ParaStyle:本文><0173>
<ParaStyle:本文><00E6>
<ParaStyle:本文><0153>
<ParaStyle:本文><00F8>
<ParaStyle:本文><0133>
<ParaStyle:本文><00DF>
<ParaStyle:本文><00FE>
