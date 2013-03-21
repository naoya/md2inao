# Markdown to Inao-Format

[![Build Status](https://travis-ci.org/naoya/md2inao.pl.png?branch=master)](https://travis-ci.org/naoya/md2inao.pl)

Markdown で書かれたテキストを「inaoフォーマット」に変換します。

* bin/md2inao.pl : CUIコマンド版
* http://md2inao.bloghackers.net/ : Web版

markdown2inao.pl 改め md2inao.pl のこれまでについては https://gist.github.com/inao/baea09bc6fc53551886b を見て下さい。

How to use
----------

    % cpanm Carton
    % carton
    % carton exec perl bin/md2inao.pl your_markdown.md > path/to/output.txt
    
出力見本
----------

PDFにすると、以下のような仕上がりになります。

### 書籍版

https://docs.google.com/open?id=0BzbGMS73rIkDUXpyUVlrSUxURXlmMXhQRV9Ua2JCUQ

### WEB+DB PRESS版

https://docs.google.com/open?id=0BzbGMS73rIkDZjdCTnBkMDFUaGF2UDJIdTNfaVJUUQ

How to test
----------

    % carton exec -Ilib -- prove  

Authors
----------

* @typester : Original version: https://gist.github.com/typester/380428
* @inao : Current product owner & maintainer
* @naoya : Refactoring, Add some tests, Web version
* @hsbt
* @hokaccha
* @suzuki

捕捉
----------

* gist から普通のレポジトリにする方法わかんなくて新規に切っちゃいました。すみません (@naoya)

LICENSE
----------

* Same as Perl
