use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== basic spec
--- in md2id
Chapter: 3
Serial: 5
Title: Markdown to Inao
Subtitle: Convert markdown text to Inao format
Author: 伊藤 直也
Author(romaji): ITO Naoya
Supervisor: 稲尾 尚徳
Supervisor(romaji): INAO Naonori
Affiliation: 技術評論社
URL: http://naoya.github.com/
mail: i.naoya@gmail.com
Github: naoya
Twitter: @naoya_ito


Hello, World
--- expected
<SJIS-MAC>
<ParaStyle:章番号・連載回数>章番号：第3章
<ParaStyle:章番号・連載回数>連載回数：第5回
<ParaStyle:タイトル>タイトル：Markdown to Inao
<ParaStyle:キャッチ>キャッチ：Convert markdown text to Inao format
<ParaStyle:本文>著者：伊藤 直也
<ParaStyle:本文>著者（ローマ字）：ITO Naoya
<ParaStyle:本文>監修：稲尾 尚徳
<ParaStyle:本文>監修（ローマ字）：INAO Naonori
<ParaStyle:本文>所属：技術評論社
<ParaStyle:本文>URL：http://naoya.github.com/
<ParaStyle:本文>mail：i.naoya@gmail.com
<ParaStyle:本文>Github：naoya
<ParaStyle:本文>Twitter：@naoya_ito
<ParaStyle:本文>Hello, World
