use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2id
<div class='column'>
#### コラム：タイトル

あいうえお。

* abc
     * def

あいうえお。

<dl>
  <dt>abc</dt>
  <dd>def</dd>
</dl>
</div>
--- expected
<SJIS-MAC>
<ParaStyle:コラムタイトル>コラム：タイトル
<ParaStyle:コラム本文>あいうえお。
<ParaStyle:コラム半行アキ>
<ParaStyle:コラム箇条書き>・abc
<ParaStyle:コラム箇条書き2階層目>・def
<ParaStyle:コラム本文>あいうえお。
<ParaStyle:コラム半行アキ>
<ParaStyle:コラム箇条書き>・abc
<ParaStyle:コラム箇条書き説明>def

===
--- in md2id
あいうえお。

<dl>
  <dt>abc</dt>
  <dd>def</dd>
</dl>
--- expected
<SJIS-MAC>
<ParaStyle:本文>あいうえお。
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・abc
<ParaStyle:箇条書き説明>def
