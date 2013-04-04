package Text::Md2Inao::Builder;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;

use Text::Md2Inao::Logger;

has dispatch_table => ( is => 'rw' );

has before_filter_config  => ( is => 'rw' );
has after_filter_config  => ( is => 'rw' );

{
    my %singleton;
    sub new {
        my $class = shift;
        $singleton{$class}
            ? return $singleton{$class}
            : return $singleton{$class} = $class->SUPER::new({ dispatch_table => {} });
    }
}

sub dispatch {
    my ($self, $select) = @_;
    return $self->dispatch_table->{$select} || $self->dispatch_table->{default};
}

sub before_filter {
    my ($self, $c, $in) = @_;
    if (my $config = $self->before_filter_config) {
        for my $k (keys %$config) {
            $in =~ s/$k/$config->{$k}/eg;
        }
    }
    return $in;
}

sub after_filter {
    my ($self, $c, $out) = @_;
    if (my $config = $self->after_filter_config) {
        for my $k (keys %$config) {
            $out =~ s/$k/$config->{$k}/eg;
        }
    }
    return $out;
}

## DSL
use Exporter::Lite;
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
