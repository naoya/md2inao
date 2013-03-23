use utf8;
use Test::More;
use Text::Md2Inao;

my $p = Text::Md2Inao->new;

my $h = HTML::Element->new('code');
$h->push_content('use strict');
is inode($p, $h)->to_inao, '◆cmd/◆use strict◆/cmd◆';

done_testing;
