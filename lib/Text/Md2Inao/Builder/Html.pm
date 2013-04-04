package Text::Md2Inao::Builder::Html;
use utf8;
use strict;
use warnings;

use parent qw/Text::Md2Inao::Builder/;

use Text::Md2Inao::Builder::DSL;

case default => sub {
    my ($c, $h) = @_;
    $h->as_HTML('', '', {});
};

1;
