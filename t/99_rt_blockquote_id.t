use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== keep white space
--- in md2id
> 引
> 用
>
> です。
--- expected
<SJIS-MAC>
<ParaStyle:引用>引用
<ParaStyle:引用>です。
