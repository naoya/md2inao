use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

my $in = <<EOF;
通常の本文**太字**通常の本文
EOF

is $p->parse($in), <<EOF;
通常の本文◆b/◆太字◆/b◆通常の本文
EOF

done_testing;
