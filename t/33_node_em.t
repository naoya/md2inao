use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new('em');
$h->push_content('hoge');
is inode($p, $h, { special_italic => 1 })->to_inao, '◆i-j/◆hoge◆/i-j◆';

done_testing;
