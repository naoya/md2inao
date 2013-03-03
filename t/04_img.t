use utf8;
use strict;
use warnings;
use Test::More;

use Text::Md2Inao;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

my $in = <<EOF;
hoge ![Command Line Toolsのインストール](http://cdn.bloghackers.net/images/20130220_204748.png) fuga

hoge ![Command Line Toolsのインストール](http://cdn.bloghackers.net/images/20130220_204748.png) fuga

hoge <img src="http://cdn.bloghackers.net/images/20130220_204748.png" title="Command Line Toolsのインストール"> fuga
EOF

is $p->parse($in), <<EOF;
hoge ●図1::Command Line Toolsのインストール[http://cdn.bloghackers.net/images/20130220_204748.png] fuga
hoge ●図2::Command Line Toolsのインストール[http://cdn.bloghackers.net/images/20130220_204748.png] fuga
hoge ●図3::Command Line Toolsのインストール[http://cdn.bloghackers.net/images/20130220_204748.png] fuga
EOF

done_testing;
