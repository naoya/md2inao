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
