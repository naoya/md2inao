use utf8;
use Test::Base;
use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

plan tests => 1 * blocks;
run_is in => 'expected';

sub md2inao {
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        blank_style            => 'full',
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
<ParaStyle:本文>
<ParaStyle:箇条書き>・Hello
<ParaStyle:箇条書き>・World

===
--- in md2inao
    use strict;
--- expected
<SJIS-MAC>
<ParaStyle:本文>
<ParaStyle:リスト>use strict;

===
--- in md2inao
1. Hello
2. World
--- expected
<SJIS-MAC>
<ParaStyle:本文>
<ParaStyle:箇条書き><CharStyle:丸文字><2776><CharStyle:>Hello
<ParaStyle:箇条書き><CharStyle:丸文字><2777><CharStyle:>World
