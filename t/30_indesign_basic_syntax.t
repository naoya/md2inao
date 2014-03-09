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
<ParaStyle:本文>これは<cstyle:上付き><fnStart:><pstyle:注釈>ここは注釈です<fnEnd:><cstyle:>です

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
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・通常の箇条書き
<ParaStyle:箇条書き>・<CharStyle:太字>強調<CharStyle:>
<ParaStyle:箇条書き>・<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>

=== nested list
--- in md2inao
- Hello
    - Markdown
    - Inao
    - InDesign
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き2階層目>・Markdown
<ParaStyle:箇条書き2階層目>・Inao
<ParaStyle:箇条書き2階層目>・InDesign

=== ordered list (disc)
--- in md2inao
1. 連番箇条書き（黒丸数字）
2. 連番箇条書き（黒丸数字）
3. 連番箇条書き（黒丸数字）
4. 連番箇条書き（黒丸数字）
5. 連番箇条書き（黒丸数字）
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><2776><CharStyle:>連番箇条書き（黒丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2777><CharStyle:>連番箇条書き（黒丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2778><CharStyle:>連番箇条書き（黒丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2779><CharStyle:>連番箇条書き（黒丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><277a><CharStyle:>連番箇条書き（黒丸数字）

=== ordered list (circle)
--- in md2inao
<ol class='circle'>
    <li>連番箇条書き（白丸数字）</li>
    <li>連番箇条書き（白丸数字）</li>
    <li>連番箇条書き（白丸数字）</li>
    <li>連番箇条書き（白丸数字）</li>
    <li>連番箇条書き（白丸数字）</li>
</ol>
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><2460><CharStyle:>連番箇条書き（白丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2461><CharStyle:>連番箇条書き（白丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2462><CharStyle:>連番箇条書き（白丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2463><CharStyle:>連番箇条書き（白丸数字）
<ParaStyle:箇条書き><CharStyle:丸文字><2464><CharStyle:>連番箇条書き（白丸数字）

=== ordered list (square)
--- in md2inao
<ol class='square'>
    <li>連番箇条書き（黒四角数字）</li>
    <li>連番箇条書き（黒四角数字）</li>
    <li>連番箇条書き（黒四角数字）</li>
    <li>連番箇条書き（黒四角数字）</li>
    <li>連番箇条書き（黒四角数字）</li>
</ol>
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>1<cTypeface:><cFont:><cotfcalt:><cotfl:>連番箇条書き（黒四角数字）
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>2<cTypeface:><cFont:><cotfcalt:><cotfl:>連番箇条書き（黒四角数字）
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>3<cTypeface:><cFont:><cotfcalt:><cotfl:>連番箇条書き（黒四角数字）
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>4<cTypeface:><cFont:><cotfcalt:><cotfl:>連番箇条書き（黒四角数字）
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>5<cTypeface:><cFont:><cotfcalt:><cotfl:>連番箇条書き（黒四角数字）

=== ordered list (alpha)
--- in md2inao
<ol class='alpha'>
    <li>連番箇条書き（アルファベット）</li>
    <li>連番箇条書き（アルファベット）</li>
    <li>連番箇条書き（アルファベット）</li>
    <li>連番箇条書き（アルファベット）</li>
    <li>連番箇条書き（アルファベット）</li>
</ol>
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>a<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>連番箇条書き（アルファベット）
<ParaStyle:箇条書き><CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>b<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>連番箇条書き（アルファベット）
<ParaStyle:箇条書き><CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>c<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>連番箇条書き（アルファベット）
<ParaStyle:箇条書き><CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>d<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>連番箇条書き（アルファベット）
<ParaStyle:箇条書き><CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>e<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>連番箇条書き（アルファベット）

=== numbers in body
--- in md2inao
　箇条書き以外の本文やリスト中で番号を書きたいときは、(d1)、(d2)、(c1)、(c2)、(s1)、(s2)、(a1)、(a2)のように書いてください。
--- expected
<ParaStyle:本文>　箇条書き以外の本文やリスト中で番号を書きたいときは、<CharStyle:丸文字><2776><CharStyle:>、<CharStyle:丸文字><2777><CharStyle:>、<CharStyle:丸文字><2460><CharStyle:>、<CharStyle:丸文字><2461><CharStyle:>、<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>1<cTypeface:><cFont:><cotfcalt:><cotfl:>、<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>2<cTypeface:><cFont:><cotfcalt:><cotfl:>、<CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>a<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>、<CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>b<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>のように書いてください。

=== numbers in body but escaped
--- in md2inao
(\d1)
--- expected
<ParaStyle:本文>(d1)

=== numbers in body and lists
--- in md2inao
### 本文やリスト中での番号

　箇条書き以外の本文やリスト中で番号を書きたいときは、(d1)、(d2)、(c1)、(c2)、(s1)、(s2)、(a1)、(a2)のように書いてください。

<ol class='square'>
    <li>hogehogeをします</li>
    <li>fugafugaと(s1)の結果を足し合わせます</li>
</ol>

　リスト1.1(c1)ではアラートを出しています。(c2)でもアラートを出しています。(\a1)エスケープできます。

    ●リスト1.1::キャプション（コードのタイトル）
    function hoge() {
        alert(foo);　… (c1)
        alert(bar);　… (c2)
        alert(\c1); // \でエスケープできます
    }
--- expected
<ParaStyle:小見出し>本文やリスト中での番号
<ParaStyle:本文>　箇条書き以外の本文やリスト中で番号を書きたいときは、<CharStyle:丸文字><2776><CharStyle:>、<CharStyle:丸文字><2777><CharStyle:>、<CharStyle:丸文字><2460><CharStyle:>、<CharStyle:丸文字><2461><CharStyle:>、<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>1<cTypeface:><cFont:><cotfcalt:><cotfl:>、<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>2<cTypeface:><cFont:><cotfcalt:><cotfl:>、<CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>a<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>、<CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>b<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>のように書いてください。
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>1<cTypeface:><cFont:><cotfcalt:><cotfl:>hogehogeをします
<ParaStyle:箇条書き><cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>2<cTypeface:><cFont:><cotfcalt:><cotfl:>fugafugaと<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>1<cTypeface:><cFont:><cotfcalt:><cotfl:>の結果を足し合わせます
<ParaStyle:本文>　リスト1.1<CharStyle:丸文字><2460><CharStyle:>ではアラートを出しています。<CharStyle:丸文字><2461><CharStyle:>でもアラートを出しています。(a1)エスケープできます。
<ParaStyle:キャプション>リスト1.1	キャプション（コードのタイトル）
<ParaStyle:リスト>function hoge() {
<ParaStyle:リスト>    alert(foo);　… <CharStyle:丸文字><2460><CharStyle:>
<ParaStyle:リスト>    alert(bar);　… <CharStyle:丸文字><2461><CharStyle:>
<ParaStyle:リスト>    alert(c1); // \でエスケープできます
<ParaStyle:リスト>}


=== pre
--- in md2inao
    function bar(b) {
        alert(b);
    }
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}

=== pre
--- in md2inao
```
function bar(b) {
    alert(b);
}
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}

=== notes in pre
--- in md2inao
    function bar(b) {
        alert(b); (注:コメント)
    }
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b); <CharStyle:リストコメント> コメント <CharStyle:>
<ParaStyle:リスト>}

=== notes in pre
--- in md2inao
```
function bar(b) {
    alert(b); (注:コメント)
}
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b); <CharStyle:リストコメント> コメント <CharStyle:>
<ParaStyle:リスト>}

=== notes in pre #2
--- in md2inao
    (注:見出し的にも使えます)
    function bar(b) {
        alert(b);
    }
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト><CharStyle:リストコメント> 見出し的にも使えます <CharStyle:>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}

=== notes in pre #2
--- in md2inao
```
(注:見出し的にも使えます)
function bar(b) {
    alert(b);
}
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト><CharStyle:リストコメント> 見出し的にも使えます <CharStyle:>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}

=== caption in pre
--- in md2inao
    ●リスト1.1::キャプション
    use strict;
--- expected
<ParaStyle:キャプション>リスト1.1	キャプション
<ParaStyle:リスト>use strict;

=== caption in pre
--- in md2inao
```
●リスト1.1::キャプション
use strict;
```
--- expected
<ParaStyle:キャプション>リスト1.1	キャプション
<ParaStyle:リスト>use strict;

=== em/italic in pre
--- in md2inao
    **use strict**;
    ___foo('bar');___ // コード内___イタリック___
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト><CharStyle:コマンド太字>use strict<CharStyle:>;
<ParaStyle:リスト><CharStyle:イタリック（変形斜体）>foo('bar');<CharStyle:> // コード内<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>

=== em/italic in pre
--- in md2inao
```
**use strict**;
___foo('bar');___ // コード内___イタリック___
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト><CharStyle:コマンド太字>use strict<CharStyle:>;
<ParaStyle:リスト><CharStyle:イタリック（変形斜体）>foo('bar');<CharStyle:> // コード内<CharStyle:イタリック（変形斜体）>イタリック<CharStyle:>

=== pre for command
--- in md2inao
    !!! cmd
    ●図1.1::キャプション（コマンドのタイトル）
    $ command  **foo** // コマンド内強調
    bar (注:こんな風にコメントがつけられます)

    (注:見出し的にも使えます)
    function bar(b) {
        alert(b);
    }
--- expected
<ParaStyle:キャプション>図1.1	キャプション（コマンドのタイトル）
<ParaStyle:リスト白文字>$ command  <CharStyle:コマンド太字>foo<CharStyle:> // コマンド内強調
<ParaStyle:リスト白文字>bar <CharStyle:リストコメント白地黒文字> こんな風にコメントがつけられます <CharStyle:>
<ParaStyle:リスト白文字>
<ParaStyle:リスト白文字><CharStyle:リストコメント白地黒文字> 見出し的にも使えます <CharStyle:>
<ParaStyle:リスト白文字>function bar(b) {
<ParaStyle:リスト白文字>    alert(b);
<ParaStyle:リスト白文字>}

=== pre for command
--- in md2inao
```
!!! cmd
●図1.1::キャプション（コマンドのタイトル）
$ command  **foo** // コマンド内強調
bar (注:こんな風にコメントがつけられます)

(注:見出し的にも使えます)
function bar(b) {
    alert(b);
}
```
--- expected
<ParaStyle:キャプション>図1.1	キャプション（コマンドのタイトル）
<ParaStyle:リスト白文字>$ command  <CharStyle:コマンド太字>foo<CharStyle:> // コマンド内強調
<ParaStyle:リスト白文字>bar <CharStyle:リストコメント白地黒文字> こんな風にコメントがつけられます <CharStyle:>
<ParaStyle:リスト白文字>
<ParaStyle:リスト白文字><CharStyle:リストコメント白地黒文字> 見出し的にも使えます <CharStyle:>
<ParaStyle:リスト白文字>function bar(b) {
<ParaStyle:リスト白文字>    alert(b);
<ParaStyle:リスト白文字>}

=== pre for command, no caption
--- in md2inao
    !!! cmd
    function bar(b) {
        alert(b); (注:コメント)
    }
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>function bar(b) {
<ParaStyle:リスト白文字>    alert(b); <CharStyle:リストコメント白地黒文字> コメント <CharStyle:>
<ParaStyle:リスト白文字>}

=== pre for command, no caption
--- in md2inao
```
!!! cmd
function bar(b) {
    alert(b); (注:コメント)
}
```
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト白文字>function bar(b) {
<ParaStyle:リスト白文字>    alert(b); <CharStyle:リストコメント白地黒文字> コメント <CharStyle:>
<ParaStyle:リスト白文字>}
=== list
--- in md2inao
    * ハイフンになる

    a

あ

    * ハイフンにならない
    * ハイフンになる

    a
--- expected
<ParaStyle:半行アキ>
<ParaStyle:リスト>* ハイフンになる
<ParaStyle:半行アキ>
<ParaStyle:リスト>a
<ParaStyle:本文>あ
<ParaStyle:半行アキ>
<ParaStyle:リスト>* ハイフンにならない
<ParaStyle:リスト>* ハイフンになる
<ParaStyle:半行アキ>
<ParaStyle:リスト>a

=== anchor
--- in md2inao
[RubyMotion](http://rubymotion.com)
--- expected
<ParaStyle:本文>RubyMotion<cstyle:上付き><fnStart:><pstyle:注釈>http://rubymotion.com<fnEnd:><cstyle:>

=== img
--- in md2inao
![Command Line Tool](http://cdn.bloghackers.net/images/20130220_204748.png)
--- expected
<ParaStyle:キャプション>●図1	Command Line Tool
<ParaStyle:赤字段落>http://cdn.bloghackers.net/images/20130220_204748.png

=== dl
--- in md2inao
<dl>
  <dt>Xenoblade</dt>
  <dd>Fiorung</dd>
  <dd>Shulk</dd>
</dl>
--- expected
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Xenoblade
<ParaStyle:箇条書き説明>Fiorung
<ParaStyle:箇条書き説明>Shulk

=== table
--- in md2inao
<table summary='表1.1::キャプション（表のタイトル）'>
    <tr>
        <th>表タイトル1</th>
        <th>表タイトル2</th>
    </tr>
    <tr>
        <td>内容1</td>
        <td>内容2</td>
    </tr>
    <tr>
        <td>内容1</td>
        <td>内容2</td>
    </tr>
</table>
--- expected
<ParaStyle:キャプション>表1.1	キャプション（表のタイトル）
<ParaStyle:表見出し行>表タイトル1	表タイトル2
<ParaStyle:表>内容1	内容2
<ParaStyle:表>内容1	内容2

=== horizontal rule
--- in md2inao
Hello

---

World
--- expected
<ParaStyle:本文>Hello
<ParaStyle:区切り線>
<ParaStyle:本文>World

