use utf8;

use Test::Base;
use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

use Encode;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => Text::Md2Inao::Builder::InDesign->new,
    });
    $p->parse($_);
}

__END__
=== h1
--- in md2inao
# 見出し1（大見出し、節）
--- expected
<ParaStyle:大見出し>見出し1（大見出し、節）

=== h2
--- in md2inao
## 見出し2（中見出し、項）
--- expected
<ParaStyle:中見出し>見出し2（中見出し、項）

=== h3
--- in md2inao
### 見出し3（小見出し、目）
--- expected
<ParaStyle:小見出し>見出し3（小見出し、目）

=== p
--- in md2inao
　段落冒頭の字下げは、このように手動でお願いします。
改行は、（改行）このように自動で取り除かれます。
--- expected
<ParaStyle:本文>　段落冒頭の字下げは、このように手動でお願いします。改行は、（改行）このように自動で取り除かれます。

=== strong
--- in md2inao
これは**太字**です
--- expected
<ParaStyle:本文>これは<CharStyle:太字>太字<CharStyle:>です

=== em
--- in md2inao
これは_イタリック_です
--- expected
<ParaStyle:本文>これは<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>です

=== code
--- in md2inao
これは`インラインのコード`です
--- expected
<ParaStyle:本文>これは<CharStyle:コマンド>インラインのコード<CharStyle:>です

=== footnote
--- in md2inao
これは(注:ここは注釈です)です
--- expected
<ParaStyle:本文>これは<fnStart:><pstyle:注釈>ここは注釈です<fnEnd:><cstyle:>です

=== kbd
--- SKIP in md2inao
通常の本文<kbd>Enter</kbd>（←キーボードフォント）
--- expected
<ParaStyle:本文>通常の本文<cFont:Key Mother><00A9><cFont:>（←キーボードフォント）

=== red
--- in md2inao
これは<span class="red">赤文字</span>です
--- expected
<ParaStyle:本文>これは<CharStyle:赤字>赤文字<CharStyle:>です

=== ruby
--- in md2inao
ルビつきの語<span class="ruby">外村(ほかむら)</span>です
--- expected
<ParaStyle:本文>ルビつきの語<cr:1><crstr:ほかむら><cmojir:0>外村<cr:><crstr:><cmojir:>です

=== blockquote
--- in md2inao
> これは引用です。
> これは引用です。
> これは引用です。
> これは**強調**と_イタリック_です。
--- expected
<ParaStyle:引用>
<ParaStyle:引用>これは引用です。これは引用です。これは引用です。これは<CharStyle:太字>強調<CharStyle:>と<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>です。

=== column
--- in md2inao
<div class="column">
#### コラム見出し

　コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム。

##### コラム小見出し

　コラム内でも**強調**や_イタリック_などが使えます。
</div>
--- expected
<ParaStyle:コラム本文>
<ParaStyle:コラムタイトル>コラム見出し
<ParaStyle:コラム本文>　コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム本文コラム。
<ParaStyle:コラム小見出し>コラム小見出し
<ParaStyle:コラム本文>　コラム内でも<CharStyle:太字>強調<CharStyle:>や<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>などが使えます。

=== list
--- in md2inao
* 通常の箇条書き
* 通常の箇条書き
* 通常の箇条書き
* **強調**
* _イタリック_
--- expected
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・<CharStyle:太字>強調<CharStyle:>
<ParaStyle:箇条書き>・<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>

