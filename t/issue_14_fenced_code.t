use 5.10.0;
use utf8;
use strict;
use warnings;

use Test::Base;
use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

use Encode;

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
=== code, code
--- in md2inao
```
abcd
```
```
efgh
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト>efgh

=== command, command
--- in md2inao
```
!!! cmd
abcd
```
```
!!! cmd
efgh
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>efgh

=== caption-code, caption-code
--- in md2inao
```
●リスト1::LTSVのParse結果
abcd
```
```
●リスト1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd

=== caption-command, caption-command
--- in md2inao
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd

=== caption-code, caption-command
--- in md2inao
```
●リスト1::Rubyによる簡易LTSV Parser
abcd
```
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:キャプション>リスト1	Rubyによる簡易LTSV Parser
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd

=== caption-command, caption-code
--- in md2inao
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
```
●リスト1::Rubyによる簡易LTSV Parser
abcd
```
--- expected
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>リスト1	Rubyによる簡易LTSV Parser
<ParaStyle:リスト>abcd

=== code, caption-code
--- in md2inao
```
abcd
```
```
●リスト1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd

=== caption-code, code
--- in md2inao
```
●リスト1::LTSVのParse結果
abcd
```
```
abcd
```
--- expected
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd

=== command, caption-command
--- in md2inao
```
!!! cmd
abcd
```
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd

=== caption-command, command
--- in md2inao
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
```
!!! cmd
abcd
```
--- expected
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd

=== code, caption-command
--- in md2inao
```
abcd
```
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd

=== caption-code, command
--- in md2inao
```
●リスト1::LTSVのParse結果
abcd
```
```
!!! cmd
abcd
```
--- expected
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd

=== command, caption-code
--- in md2inao
```
!!! cmd
abcd
```
```
●リスト1::LTSVのParse結果
abcd
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:キャプション>リスト1	LTSVのParse結果
<ParaStyle:リスト>abcd

=== caption-command, code
--- in md2inao
```
!!! cmd
●図1::LTSVのParse結果
abcd
```
```
abcd
```
--- expected
<ParaStyle:キャプション>図1	LTSVのParse結果
<ParaStyle:リスト白文字>abcd
<ParaStyle:本文>
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd

=== code (blank line)
--- in md2inao
```
abcd

efgh
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>abcd
<ParaStyle:リスト>
<ParaStyle:リスト>efgh

=== command (blank line)
--- in md2inao
```
!!! cmd
abcd

efgh
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>abcd
<ParaStyle:リスト白文字>
<ParaStyle:リスト白文字>efgh

