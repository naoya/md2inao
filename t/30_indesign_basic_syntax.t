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

=== nested list
--- in md2inao
- Hello
    - Markdown
    - Inao
    - InDesign
--- expected
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
--- SKIP in md2inao
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

=== pre
--- in md2inao
    function bar(b) {
        alert(b);
    }
--- expected
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}

=== notes in pre
--- in md2inao
    function bar(b) {
        alert(b); (注:コメント)
    }
--- expected
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
<ParaStyle:リスト><CharStyle:リストコメント> 見出し的にも使えます <CharStyle:>
<ParaStyle:リスト>function bar(b) {
<ParaStyle:リスト>    alert(b);
<ParaStyle:リスト>}
