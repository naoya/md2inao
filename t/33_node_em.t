use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new('em');
$h->push_content('hoge');
is inode($p, $h)->to_inao, '◆i/◆hoge◆/i◆';

done_testing;
