use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== basic spec
--- in md2inao
Title: Markdown to Inao
Subtitle: Convert markdown text to Inao format
Chapter: 3
Serial: 5
Author: 伊藤 直也
Supervisor: 稲尾
URL: http://naoya.github.com/
mail: i.naoya@gmail.com
Github: naoya
Twitter: @naoya_ito


Hello, World
--- expected
章番号：第3章
連載回数：第5回
タイトル：Markdown to Inao
キャッチ：Convert markdown text to Inao format
著者：伊藤 直也
監修：稲尾
URL：http://naoya.github.com/
mail：i.naoya@gmail.com
Github：naoya
Twitter：@naoya_ito
Hello, World

=== no metadata
--- in md2inao
Hello
World
--- expected
HelloWorld

=== like metadata but not metadata
--- in md2inao
Title: Markdown to Inao
Hello
--- expected
Title: Markdown to InaoHello

=== like metadata but not metadata #2
--- in md2inao
Title: Markdown to Inao
Hello
Hoge: Fuga

Hello
--- expected
Title: Markdown to InaoHelloHoge: Fuga
Hello
