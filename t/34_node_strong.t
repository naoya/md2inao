use utf8;
use Test::More;
use Text::Md2Inao;

my $h = HTML::Element->new('strong');
$h->push_content('hoge');

is inode($h)->to_inao, "◆b/◆hoge◆/b◆";

done_testing;
