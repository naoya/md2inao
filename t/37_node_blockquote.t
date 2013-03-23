use utf8;
use Test::More;
use Text::Md2Inao;

my $html = <<EOF;
<blockquote>
<p>blah blah</p>
</blockquote>
EOF

my $tree = HTML::TreeBuilder->new;
$tree->no_space_compacting(1);
$tree->parse_content(\$html);

my $p = Text::Md2Inao->new;

is inode($p, $tree->guts)->to_inao, <<EOF;
◆quote/◆
blahblah
◆/quote◆
EOF

done_testing;
