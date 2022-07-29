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
* (d1)箇条書き
    * (d1)箇条書き2
* (d2)箇条書き
    * (d1)箇条書き2
* (d3)箇条書き
    * (d1)箇条書き2
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き><CharStyle:丸文字><2776><CharStyle:>箇条書き
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2776><CharStyle:>箇条書き2
<ParaStyle:箇条書き><CharStyle:丸文字><2777><CharStyle:>箇条書き
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2776><CharStyle:>箇条書き2
<ParaStyle:箇条書き><CharStyle:丸文字><2778><CharStyle:>箇条書き
<ParaStyle:箇条書き2階層目><CharStyle:丸文字><2776><CharStyle:>箇条書き2

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
