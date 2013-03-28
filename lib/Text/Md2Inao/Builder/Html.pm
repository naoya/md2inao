package Text::Md2Inao::Builder::Html;
use utf8;
use strict;
use warnings;

use Text::Md2Inao::Builder;
use parent qw/Text::Md2Inao::Builder/;

case default => sub {
    my ($c, $h) = @_;
    $h->as_HTML('', '', {});
};

1;
