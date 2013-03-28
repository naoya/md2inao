## THIS MODULE IS STILL UNDER DEVELOPMENT
package Text::Md2Inao::Builder::InDesign;
use utf8;
use strict;
use warnings;

use Text::Md2Inao::Builder;
use parent qw/Text::Md2Inao::Builder/;

case default => sub {
    my ($c, $h) = @_;
    $h->as_HTML('', '', {});
};

case text => sub {
    my ($c, $text) = @_;
    return $text;
};

case "h1" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:大見出し>%s\n", $h->as_trimmed_text;
};

case "strong" => sub {
    my ($c, $h) = @_;
    return sprintf "<CharStyle:太字>%s<CharStyle:>", $h->as_trimmed_text;
};

case p => sub {
    my ($c, $h) = @_;
    my $text = $c->parse_element($h);
    if ($text !~ /^[\s　]+$/) {
        return sprintf "<ParaStyle:本文>%s\n", $text;
    }
};

1;

