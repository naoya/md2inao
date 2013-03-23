use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new(
    'img',
    src   => 'http://cdn.bloghackers.net/images/20130220_204748.png',
    title => 'Command Line Toolsのインストール'
);

is inode($p, $h)->to_inao, <<EOF;
●図1	Command Line Toolsのインストール
http://cdn.bloghackers.net/images/20130220_204748.png
EOF

done_testing;
