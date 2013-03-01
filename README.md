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
* @naoya : Refactoring, Add some tests
* @hsbt
* @hokaccha

捕捉
----------

* gist から普通のレポジトリにする方法わかんなくて新規に切っちゃいました。すみません (@naoya)

TODO
----------

* utf8 string の扱いが旧態依然としたスタイルなので正しい方法に切り替える
