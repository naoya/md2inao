use utf8;
use Test::More;
use Text::Md2Inao;

my $h = HTML::Element->new('em');
$h->push_content('hoge');
is inode($h, { special_italic => 1 })->to_inao, '◆i-j/◆hoge◆/i-j◆';

done_testing;
