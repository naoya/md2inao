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
===
--- in md2inao
hogehoge
fugafuga
--- expected
hogehogefugafuga

===
--- in md2inao
　hogehoge
fugafuga
--- expected
　hogehogefugafuga

===
--- in md2inao
　hogehoge
　fugafuga
--- expected
　hogehoge
　fugafuga

===
--- in md2inao
hogehoge
　fugafuga
--- expected
hogehoge
　fugafuga

===
--- in md2inao
　hogehoge

　fugafuga
--- expected
　hogehoge
　fugafuga
