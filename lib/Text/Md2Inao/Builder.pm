package Text::Md2Inao::Builder;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;

use JSON;
use Path::Tiny;

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

sub load_filter_config {
    my ($self, $path) = @_;
    my $json = path($path)->slurp;
    my $config = decode_json $json;
    for (qw/before_filter after_filter/) {
        if ($config->{$_}) {
            my $meth = sprintf "%s_config", $_;
            $self->$meth($config->{$_});
        }
    }
}

sub before_filter {
    my ($self, $c, $in) = @_;
    if (my $config = $self->before_filter_config) {
        for my $k (keys %$config) {
            my $v = $config->{$k};

            ## Markdown が html として処理しないようエスケープ
            ## 実体参照へのエスケープだと InDesign で困る
            ## 独自に escape して after_filter で戻す
            $v =~ s/</◆lt◆/g;
            $v =~ s/>/◆gt◆/g;

            $in =~ s/$k/$v/eg;
        }
    }
    return $in;
}

sub after_filter {
    my ($self, $c, $out) = @_;
    $out =~ s/◆lt◆/</g;
    $out =~ s/◆gt◆/>/g;
    if (my $config = $self->after_filter_config) {
        for my $k (keys %$config) {
            $out =~ s/$k/$config->{$k}/eg;
        }
    }
    return $out;
}

1;
