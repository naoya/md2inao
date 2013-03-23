use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new('kbd');
$h->push_content('Enter');
is inode($p, $h)->to_inao, 'Enter▲';

done_testing;
