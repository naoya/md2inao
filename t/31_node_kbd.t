use utf8;
use Test::More;
use Text::Md2Inao;

{
    my $h = HTML::Element->new('kbd');
    $h->push_content('Enter');
    is inode($h)->to_inao, 'Enter▲';
}

done_testing;
