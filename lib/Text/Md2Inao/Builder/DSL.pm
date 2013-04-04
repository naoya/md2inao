package Text::Md2Inao::Builder::DSL;
use strict;
use warnings;

use Text::Md2Inao::Logger;

use parent qw/Exporter/;
our @EXPORT = qw/case fallback_to_html/;

sub case ($&) {
    my ($select, $code) = @_;
    my $class = (caller)[0];
    my $self = $class->new;
    for (split ",", $select) {
        s/\s+//g;
        $self->dispatch_table->{$_} = $code;
    }
}

sub fallback_to_html {
    my $h = shift;
    log warn => sprintf "HTMLタグは `<%s>` でエスケープしてください。しない場合の出力は不定です", $h->tag;
    return $h->as_HTML('', '', {});
}

1;
