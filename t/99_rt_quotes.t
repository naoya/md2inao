use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== keep white space
--- in md2inao
> a b c d e f.
> 
> は ん か く あ き
> 
> ぜ　ん　か　く　あ　き
--- expected
◆quote/◆
a b c d e f.
は ん か く あ き
ぜ　ん　か　く　あ　き
◆/quote◆

===
--- in md2inao
> 引用
> です
> よね
--- expected
◆quote/◆
引用ですよね
◆/quote◆

===
--- in md2inao
改行
です
よね
--- expected
改行ですよね

===
--- in md2inao
> ABC
> 
> DEF
> 
> GHI
--- expected
◆quote/◆
ABC
DEF
GHI
◆/quote◆

===
--- in md2inao
ABC

DEF

GHI
--- expected
ABC
DEF
GHI
