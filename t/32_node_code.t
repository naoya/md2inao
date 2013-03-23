use utf8;
use Test::More;
use Text::Md2Inao;

{
    my $h = HTML::Element->new('code');
    $h->push_content('use strict');
    is inode($h)->to_inao, '◆cmd/◆use strict◆/cmd◆';
}

done_testing;
