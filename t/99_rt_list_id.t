use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2id
* Hello
    * World
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き2階層目>・World

===
--- in md2id
* Hello
    * World
* Good Bye
    * World
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き2階層目>・World
<ParaStyle:箇条書き>・Good Bye
<ParaStyle:箇条書き2階層目>・World

===
--- in md2id
<dl>
  <dt>1. Hello</dt>
  <dd>World</dd>
  <dt>2. Hello</dt>
  <dd>World</dd>
  <dt>3. Hello</dt>
  <dd>World</dd>
</dl>
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><2776><CharStyle:> Hello
<ParaStyle:箇条書き説明>World
<ParaStyle:箇条書き><CharStyle:丸文字><2777><CharStyle:> Hello
<ParaStyle:箇条書き説明>World
<ParaStyle:箇条書き><CharStyle:丸文字><2778><CharStyle:> Hello
<ParaStyle:箇条書き説明>World

===
--- in md2id
<ul>
  <li>1. Hello</li>
  <li>2. Hello
    <ul>
      <li>1. World</li>
      <li>2. World</li>
      <li>3. World</li>
      <li>4. World</li>
      <li>5. World</li>
    </ul>
  </li>
  <li>3. Hello</li>
</ul>
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><2776><CharStyle:> Hello
<ParaStyle:箇条書き><CharStyle:丸文字><2777><CharStyle:> Hello
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2776><CharStyle:> World
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2777><CharStyle:> World
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2778><CharStyle:> World
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2779><CharStyle:> World
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><277a><CharStyle:> World
<ParaStyle:箇条書き><CharStyle:丸文字><2778><CharStyle:> Hello

=== TODO: Markdown 側がバグってる
--- SKIP in md2id
* Hello
    * World

* Good Bye
    * World
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き2階層目>・World
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Good Bye
<ParaStyle:箇条書き2階層目>・World
