use 5.10.0;
use strict;
use warnings;
use utf8;

use Test::Base;
use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

$Text::Md2Inao::Logger::STOP = 1;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    state $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        builder                => Text::Md2Inao::Builder::InDesign->new,
    });
    return $p->parse($_);
}

__END__
=== escaped tags
--- in md2inao
This is not html &lt;code&gt;
--- expected
<SJIS-MAC>
<ParaStyle:本文>This is not html <005C><code<005C>>

=== inline command
--- in md2inao
This is not html `<code>`
--- expected
<SJIS-MAC>
<ParaStyle:本文>This is not html <CharStyle:コマンド><005C><code<005C>><CharStyle:>

=== list context
--- in md2inao
    <html>
    <body></body>
    </html>

Hello, World;
--- expected
<SJIS-MAC>
<ParaStyle:半行アキ>
<ParaStyle:リスト><005C><html<005C>>
<ParaStyle:リスト><005C><body<005C>><005C></body<005C>>
<ParaStyle:リスト><005C></html<005C>>
<ParaStyle:本文>Hello, World;

=== passing througed tags
--- in md2inao
<span class="unknown">test</span>
--- expected
<SJIS-MAC>
<ParaStyle:本文><005C><span class="unknown"<005C>>test<005C></span<005C>>
