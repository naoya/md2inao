use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new('strong');
$h->push_content('hoge');

is inode($p, $h)->to_inao, "◆b/◆hoge◆/b◆";

done_testing;
