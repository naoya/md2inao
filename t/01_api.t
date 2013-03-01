use strict;
use warnings;
use Test::More;

use Text::Md2Inao;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

my $out = $p->parse(<<EOF);
# Hello, World

* list 1
* list 2
EOF

is $out, <<EOF;
■Hello, World
・list 1
・list 2
EOF

done_testing;
