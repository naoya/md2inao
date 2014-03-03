Markdown to Inao-Format
================

[![Build Status](https://travis-ci.org/naoya/md2inao.png?branch=master)](https://travis-ci.org/naoya/md2inao) [![Coverage Status](https://coveralls.io/repos/naoya/md2inao/badge.png?branch=master)](https://coveralls.io/r/naoya/md2inao)

概要
----

Markdown で書かれたテキストを「inaoフォーマット」に変換します。

- bin/md2inao.pl : CUIコマンド版
- http://md2inao.bloghackers.net/ : Web版

markdown2inao.pl 改め md2inao.pl のこれまでについては https://gist.github.com/inao/baea09bc6fc53551886b を見て下さい。

使い方
-----

### CUI版

    % cpanm Carton
    % carton
    % carton exec -- perl bin/md2inao.pl your_markdown.md > path/to/output.txt

### Web版

- http://md2inao.bloghackers.net/

出力見本
-------

PDFにすると、以下のような仕上がりになります。

### 書籍版

- https://docs.google.com/open?id=0BzbGMS73rIkDUXpyUVlrSUxURXlmMXhQRV9Ua2JCUQ

### WEB+DB PRESS版

- https://docs.google.com/open?id=0BzbGMS73rIkDZjdCTnBkMDFUaGF2UDJIdTNfaVJUUQ

Markdownでの原稿の書き方
----------------------

md2inao を利用すると Markdown フォーマットで原稿を書くことができますが、当然のことながら、なんの制約もなく Markdown フォーマットで書けばよしなに変換してくれるというものではありません。以下、原稿を書くにあたっての Markdown の使い方について解説します。

### 原稿の例

    Title: RubyMotion入門
    Subtitle: RubyでiOSネイティブアプリ!
    Author: 伊藤 直也
    Author(romaji): ITO Naoya
    Twitter: @naoya_ito

    # RubyMotion とは

    　[RubyMotion](http://rubymotion.com/) は、RubyでiOSのネイティブアプリケーションが作れるツールチェインです。Apple で MacRuby を開発していた Laurent Sansonetti さんが Apple 退職後に興した会社 Hipbyte が、2012年5月に発売を開始しました。

    # RubyMotion で Hello, World

    　早速コードを書いてみましょう。以下が Hello, World のコードです。

        class HelloViewController < UIViewController
          def viewDidLoad
            super
            @label = UILabel.new
            @label.frame = [[10, 10], [320, 20]]
            @label.text = "Hello, World"

            view.addSubview(@label)
          end
        end

    簡単ですね！

    - HelloViewController を定義
    - `viewDidLoad` をオーバーライド
    - `UILabel.new` でラベルインスタンスを作成
    - `view.addSubview` でビューに追加

    しているだけです。出力は以下のようになります。

    ![Hello, Worldの出力](images/hello_world.png)

### 基本的な考え方

Markdown は Markdown プロセッサで解釈すると、通常は HTML に変換されます。md2inao はその書 HTML の各要素を Inao 記法 (もしくは技術評論社の InDesign フォーマット) に変換して最終的な出力を作っています。

従って Markdown を書きながらも出力される HTML 構造がどの要素になって、その要素が論理構造的にどういったものか、をある程度想定しておけばだいたい想像した通りの出力になると思ってください。

また、Markdown で定義されてない記述も HTML を使うことによって定義することもできます。一部の記法は HTML で書くことが前提になっています。

いまのところ GitHub Flavored Markdown などの拡張には対応していませんのでその点に注意してください。

#### 文中に HTML を書く際の注意事項

Markdown の仕様では当然のことながら、HTML タグは HTML タグとして解釈されます。文中に HTML を書きたい場合は以下のいずれかの方法でエスケープしてください。

##### code 記法を使う

    `<strong>`

##### 実体参照を使う

    &lt;strong&gt;

### メタデータ（タイトル、著者名など）

テキストファイルの冒頭に、以下のメタデータを書きます。メタデータには原稿や書籍のタイトル、章番号、著者名などの情報を入力してください。本メタデータは http://hiltmon.com/blog/2012/06/18/markdown-metadata/ の仕様に従っていますが、GitHub Flavored Markdown では解釈されないため、GitHub 上では HTML での表示が崩れますがスルーしてください。

    Chapter: 3（章番号）
    Serial: 5（連載回数）
    Title: Markdown to Inao（タイトル）
    Subtitle: Convert markdown text to Inao format（キャッチコピー）
    Author: 伊藤 直也（著者名）
    Author(romaji): ITO Naoya（著者名のローマ字表記）
    Supervisor: 稲尾 尚徳（監修者名）
    Supervisor(romaji): INAO Naonori（監修者名のローマ字表記）
    Affiliation: 技術評論社（所属）
    URL: http://naoya.github.com/
    mail: i.naoya@gmail.com
    GitHub: naoya
    Twitter: @naoya_ito

    Hello, World（本文）

#### 注意事項

- Title、Subtitle、Author、Author(romaji)は必須です
- テキストファイルの冒頭に書く必要があります
- メタデータと本文の間に空行が必要です
- 任意のメタデータを追加可能ですが、キーにマルチバイト文字は使えません

### 見出し

各章の配下、各記事（連載、一般記事）の配下には、見出しが3階層まで使えます。

    # 大見出し（節）
    ## 中見出し（項）
    ### 小見出し（目）

#### 非推奨

md2inao的には以下の記法にも対応していますが、現状は非推奨です（アウトラインの作成がちょっとめんどうになるので）。

    大見出し（節）
    ===============

    中見出し（項）
    ---------------

### 箇条書き（リスト）

#### 箇条書き

両記法に対応していますが、同一原稿では、どちらかで統一してください。

    * 箇条書き
    * 箇条書き
    * 箇条書き

    - 箇条書き
    - 箇条書き
    - 箇条書き

#### 階層付き箇条書き（ネストしたリスト）

両記法に対応していますが、同一原稿では、どちらかで統一していただきたいです。

    * 箇条書き
        * 箇条書き2階層目
        * 箇条書き2階層目
        * 箇条書き2階層目

    - 箇条書き
        - 箇条書き2階層目
        - 箇条書き2階層目
        - 箇条書き2階層目

##### 注意事項

* GitHub Flavored Markdownでは半角スペース1～3つの行頭字下げによるネストにも対応していますが、md2inaoは4つ以上にのみ対応しています
* 3階層目は使用できません

#### 説明つき箇条書き（dt、dd）

Markdown の説明つき箇条書きには対応していないので、HTML でマークアップしてください。

    <dl>
      <dt>箇条書き</dt>
      <dd>箇条書きの説明文</dd>
      <dt>箇条書き</dt>
      <dd>箇条書きの説明文</dd>
    </dl>

##### 注意事項

* この説明つき箇条書きのようなHTMLで記述した箇条書き中では、`_イタリック_`や`**強調**`などの文中記号は使えません（以降のHTML系の箇条書きでも同様です）

#### 連番箇条書き（黒丸数字）

黒丸囲みの1、2、3……が行頭につきます。

    1. 連番箇条書き
    2. 連番箇条書き
    3. 連番箇条書き

本文で黒丸囲みの1、2、3……を書く場合は、(d1)、(d2)、(d3)と書いてください（discのdです）。

- 手順など順列の箇条書きにのみ使用してください。
- 順列ではないけど、行頭記号を区別したい場合は、次のアルファベット箇条書きを使ってください。

###### そのほかの連番箇条書き（白丸数字、黒四角数字）

上述した連番箇条書き（黒丸数字）がデフォルトですが、白丸数字や黒四角数字にすることもできます。連番箇条書きが連続して登場し紛らわしくなる場合などにご利用ください。

    <ol class='circle'>
        <li>連番箇条書き（白丸数字）</li>
        <li>連番箇条書き（白丸数字）</li>
        <li>連番箇条書き（白丸数字）</li>
    </ol>

本文で白丸囲みの1、2、3……を書く場合は、(c1)、(c2)、(c3)と書いてください（circleのcです）。

    <ol class='square'>
        <li>連番箇条書き（黒四角数字）</li>
        <li>連番箇条書き（黒四角数字）</li>
        <li>連番箇条書き（黒四角数字）</li>
    </ol>

本文で黒四角囲みの1、2、3……を書く場合は、(s1)、(s2)、(s3)と書いてください（squareのsです）。

#### アルファベット箇条書き（黒丸囲み）

黒丸囲みのa、b、c……が行頭につきます。

    <ol class='alpha'>
        <li>アルファベット箇条書き</li>
        <li>アルファベット箇条書き</li>
        <li>アルファベット箇条書き</li>
    </ol>

本文で黒丸囲みのa、b、c……を書く場合は、(a1)、(a2)、(a3)と書いてください（alphabetのaです）。

### コードブロック（ソースコード、コマンド）

#### 本文中のコードブロック

行頭半角スペース4つで字下げします。GitHub Flavored Markdown のコードブロック記法には今のところ対応していません。

        function bar(b) {
            alert(b);
        }

`(注:)`は黒地に白文字となり、見出しやコメント的に使えます。

        (注:見出し的に使う)
        function bar(b) {
            alert(b); (注:こんな風にコメントがつけられます)
        }

#### 本文中のコマンドブロック（WEB+DB PRESSは未使用）

先頭行を`!!! cmd`とすると、コマンドラインっぽく黒地に白文字になります。

この場合の`(注:)`は、逆に白地に黒文字となります。

        !!! cmd
        (注:見出し的に使う)
        $ command
        bar (注:こんな風にコメントがつけられます)

コマンド行の行頭には、上記のようにプロンプト（$など）を書いてください。

なお、この記法を使うのは一部の書籍のみです。WEB+DB PRESSなどでは未使用で、未使用の媒体では、コマンドの場合もインラインのコードブロックと同様の書き方をしてください。

#### 別ボックスのコードブロック（リスト）

別ボックスの「リスト」として掲載するコードには、先頭行に`●リスト1::キャプション`を書いてください。

        ●リスト1::キャプション
        (注:見出し的に使う)
        function bar(b) {
            alert(b); (注:こんな風にコメントがつけられます)
        }

#### 別ボックスのコマンドブロック（図）

別ボックスの「図」として掲載するコマンドには、先頭行に`!!! cmd`と`●図1::キャプション`を書いてください。

        !!! cmd
        ●図1::キャプション`
        (注:見出し的に使う)
        $ command
        bar (注:こんな風にコメントがつけられます)

コマンド行の行頭には、上記のようにプロンプト（$など）を書いてください。

こちらはWEB+DB PRESSなどでも使います。

### 図の画像

以下の両記法に対応していますが、同一原稿では、どちらかで統一していただきたいです。

また、必ず独立した段落としてお書きください（本文段落中に書かないでください）。

    ![キャプション](images/hoge.png)

    <img src="images/hoge.png" width="320" alt="キャプション" />

### 注釈、リンク

次の2つの記法が使えます。紙面ではいずれも注釈になり、両者の違いはありません。

    [リンクの対象](URL)

    注釈の対象(注:注釈文。)

たとえば次のように書きます。

    [RubyMotion](http://rubymotion.com/)は、RubyでiOSアプリを作るれるツールです。
    $199程度(注:日本円で20,000円程度です。)です。

### 表

HTMLでマークアップしてください。

    <table summary='表1::キャプション'>
        <tr>
            <th>列の説明1</th>
            <th>列の説明2</th>
        </tr>
        <tr>
            <td>内容1-1</td>
            <td>内容2-1</td>
        </tr>
        <tr>
            <td>内容1-2</td>
            <td>内容2-2</td>
        </tr>
    </table>

### 引用

引用は次のように書きます。

    > 引用です。

#### 注意事項

GitHub Flavored Markdownとは異なり、複数行に分けて書いても1行になります。

    > 引
    > 用
    > です。

### 区切り線（`<hr>`）

    ---

### コラム

    <div class='column'>
    #### コラムタイトル
    本文
    ##### コラム小見出し
    本文
    ##### コラム小見出し
    本文
    </div>

### 字下げ

段落行頭の字下げは手動です。全角スペースを入れてください。

    　こんにちは。伊藤です。

### 段落分け

段落分けをするには、空行（2連続の改行）を入れる必要があります。

    　こんにちは。伊藤です。

    　今号から、新連載を始めます。


ただし、行頭で全角スペースによりインデントされている場合のみ、空行がなくても段落分けされ、上記の空行を入れた場合と同じ出力になります。

### 文字記法

これまでの記法は段落全体を指定する段落スタイルでしたが、ここからは段落内の文中で使う文字スタイルです。

#### 強調

    **強調（ボールド）**

#### イタリック

    _斜体（イタリック）_

#### 本文中のコードやコマンド、HTMLタグのエスケープ

    `code or command`

本文での解説中にHTMLを書きたい場合などのエスケープにもご利用ください。

    `<a>`

#### ルビ

    <span class='ruby'>外村(ほかむら)</span>

#### キーボードフォント

    <kbd>A</kbd>

#### 上付き

    <sup>ゴシックフォントで上付き。コラムなどでの注記で使用</sup>
    <sup2>その場のフォントで上付き。n乗など数式で使用</sup2>

#### 赤文字

編集者へのコメントなどでご利用ください。

    <span class='red'>赤文字</span>

★☆□▲などの記号は、上記記法を用いずとも自動で赤字になります。

md2inao デベロッパー向け情報
-------------------------

### テストの実行の仕方

    % carton exec -Ilib -- prove

### 自由置換の書き方

```
{
    "before_filter": {
        "<kbd>F10</kbd>" : "<cFont:Key Snd Mother>*<cFont:>",
        "<kbd>F11</kbd>" : "<cFont:Key Snd Mother>+<cFont:>",
        "<kbd>F12</kbd>" : "<cFont:Key Snd Mother>,<cFont:>",
        "<kbd>F1</kbd>" : "<cFont:Key Snd Mother>!<cFont:>",
        "<kbd>F2</kbd>" : "<cFont:Key Snd Mother>\"<cFont:>",
        "<kbd>End</kbd>" : "<cFont:Key Snd Mother>n<cFont:>"
    },
    "after_filter": {
        "★" : "<CharStyle:赤字>★<CharStyle:>",

        "◆→◆" : "<cTypeface:R-KL><cFont:A-OTF リュウミン Pr5><27A1><cTypeface:><cFont:>",
        "◆←◆" : "<cTypeface:R-KL><cFont:A-OTF リュウミン Pr5><2B05><cTypeface:><cFont:>",
        "◆↑◆" : "<cTypeface:R-KL><cFont:A-OTF リュウミン Pr5><2B06><cTypeface:><cFont:>",
        "◆↓◆" : "<cTypeface:R-KL><cFont:A-OTF リュウミン Pr5><2B07><cTypeface:><cFont:>",

        "◆←→◆" : "<21D4>",
        "◆＞＝◆" : "<2267>",
        "◆＝＞◆" : "<2266>",

        "◆WDB◆" : "<cstyle:ストッパ>#<cstyle:>"
    }
}
```

- InDesign 出力時は config/id_filter.json に書いた設定通りに出力を置換できます
- キーには正規表現が使えます
- JSON の文法に注意 (末尾のカンマ、" のエスケープなど)

#### before_filter

- Markdown parse の前に置換
- Markdown のテキストを置換したい時は こちら
- HTML を置換したい時もこちら
- 値の &lt;, &gt; はエスケープされてから Markdown parser に渡されます。その後 after_filter で復元されます。(要するに書いたとおりに出力される。HTMLとして処理されることは期待できない、ということ)

#### after_filter

- InDesign への変換が終わった後に置換
- InDesign になったテキストを置換したい時はこちら
- md 中の `<span class="symbol">…</span>` は after_filter 前に` ◆…◆` になります

Authors
----------

* @typester : Original version: https://gist.github.com/typester/380428
* @inao : Current product owner & maintainer
* @naoya : Refactoring, Add some tests, Web version
* @hsbt
* @hokaccha
* @suzuki

LICENSE
----------

* Same as Perl

Contributing
----------

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

IRC
----------

- `#md2inao@freenode`
