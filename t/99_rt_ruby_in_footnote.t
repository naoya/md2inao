use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== monoruby
--- in md2id
○○います(注:あいう<span class='monoruby'>辟易(へき えき)</span>えお)。
--- expected
<UNICODE-MAC>
<ParaStyle:本文>○○います<cstyle:脚注上付き><fnStart:><pstyle:脚注>あいう<cr:1><crstr:へき えき><cmojir:1>辟易<cr:><crstr:><cmojir:>えお<fnEnd:><cstyle:>。

=== groupruby
--- in md2id
○○います(注:あいう<span class='groupruby'>欠伸(あくび)</span>えお)。
--- expected
<UNICODE-MAC>
<ParaStyle:本文>○○います<cstyle:脚注上付き><fnStart:><pstyle:脚注>あいう<cr:1><crstr:あくび><cmojir:0>欠伸<cr:><crstr:><cmojir:>えお<fnEnd:><cstyle:>。
