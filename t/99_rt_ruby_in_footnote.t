use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2id
○○います(注:あいう<span class='ruby'>CRIME(クライム)</span>えお)。
--- expected
<SJIS-MAC>
<ParaStyle:本文>○○います<cstyle:上付き><fnStart:><pstyle:注釈>あいう<cr:1><crstr:クライム><cmojir:0>CRIME<cr:><crstr:><cmojir:>えお<fnEnd:><cstyle:>。
