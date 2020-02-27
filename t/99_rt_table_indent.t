use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2id
<table summary='表1::キャプション'>
  <tr>
    <th>列の説明1</th>
    <th>列の説明2</th>
  </tr>
</table>
--- expected
<SJIS-MAC>
<ParaStyle:キャプション>表1	キャプション
<ParaStyle:表見出し行>列の説明1	列の説明2

===
--- in md2id
<table summary='表1::キャプション'>
<tr>
<th>列の説明1</th>
<th>列の説明2</th>
</tr>
</table>
--- expected
<SJIS-MAC>
<ParaStyle:キャプション>表1	キャプション
<ParaStyle:表見出し行>列の説明1	列の説明2
