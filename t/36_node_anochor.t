use utf8;
use Test::More;
use Text::Md2Inao;

my $h = HTML::Element->new('a', href => "http://www.example.com");
$h->push_content('example.com');

is inode($h)->to_inao, "example.com◆注/◆http://www.example.com◆/注◆";

done_testing;
