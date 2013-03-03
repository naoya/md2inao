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
hoge [RubyMotion](http://www.rubymotion.com/) fuga
EOF

is $p->parse($in), <<EOF;
hoge RubyMotion◆注/◆http://www.rubymotion.com/◆/注◆ fuga
EOF

done_testing;
