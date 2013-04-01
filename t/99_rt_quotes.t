use utf8;

use Test::Base;
use Text::Md2Inao;
use Encode;

plan tests => 1 * blocks;
run_is in => 'expected';

sub md2inao {
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
    });
    $p->parse($_);
}

__END__
=== keep white space
--- in md2inao
> a b c d e f.
> 
> は ん か く あ き
> 
> ぜ　ん　か　く　あ　き
--- expected
◆quote/◆
a b c d e f.は ん か く あ きぜ　ん　か　く　あ　き
◆/quote◆

===
--- in md2inao
> 引用
> です
> よね
--- expected
◆quote/◆
引用ですよね
◆/quote◆

===
--- in md2inao
改行
です
よね
--- expected
改行ですよね

