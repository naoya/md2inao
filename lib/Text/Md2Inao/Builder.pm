package Text::Md2Inao::Builder;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;

use Text::Md2Inao::Logger;

has dispatch_table => ( is => 'rw' );

{
    my $singleton;
    sub new {
        my $class = shift;
        $singleton
            ? return $singleton
            : return $singleton = $class->SUPER::new({ dispatch_table => {} });
    }
}

sub dispatch {
    my ($self, $select) = @_;
    return $self->dispatch_table->{$select} || $self->dispatch_table->{default};
}

## DSL
use Exporter::Lite;
our @EXPORT = qw/case fallback_to_html/;

sub case ($&) {
    my ($select, $code) = @_;
    my $self = __PACKAGE__->new;

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
