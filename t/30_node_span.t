use utf8;
use Test::More;
use Text::Md2Inao;

{
    my $h = HTML::Element->new('span', class => 'ruby');
    $h->push_content('ルビ');
    is inode($h)->to_inao, 'ルビ';
}

{
    my $h = HTML::Element->new('span', class => 'red');
    $h->push_content('赤字');
    is inode($h)->to_inao, '◆red/◆赤字◆/red◆';
}

{
    my $h = HTML::Element->new('span', class => 'symbol');
    $h->push_content('=>');
    is inode($h)->to_inao, '◆=>◆';
}

{
    my $h = HTML::Element->new('span', class => 'unknown');
    $h->push_content('hoge');
    is inode($h)->to_inao, '<span class="unknown">hoge</span>'
}

done_testing;
