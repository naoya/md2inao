use utf8;

use Test::Base;
use Text::Md2Inao;
use Encode;
use Text::Md2Inao::Builder::InDesign;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => Text::Md2Inao::Builder::InDesign->new,
    });
    $p->parse($_);
}

__END__
===
--- in md2inao
* Hello
    * World
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き2階層目>・World

===
--- in md2inao
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
--- SKIP in md2inao
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
