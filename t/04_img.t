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
![Command Line Toolsのインストール](http://cdn.bloghackers.net/images/20130220_204748.png)

![Command Line Toolsのインストール](http://cdn.bloghackers.net/images/20130220_204748.png)

<img src="http://cdn.bloghackers.net/images/20130220_204748.png" title="Command Line Toolsのインストール">
EOF

is $p->parse($in), <<EOF;
●図1	Command Line Toolsのインストール
http://cdn.bloghackers.net/images/20130220_204748.png

●図2	Command Line Toolsのインストール
http://cdn.bloghackers.net/images/20130220_204748.png

●図3	Command Line Toolsのインストール
http://cdn.bloghackers.net/images/20130220_204748.png

EOF

done_testing;
