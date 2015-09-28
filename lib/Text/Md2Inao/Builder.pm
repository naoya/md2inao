package Text::Md2Inao::Builder;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;

use JSON;
use Path::Tiny;

has dispatch_table => ( is => 'rw' );
has math_table => ( is => 'rw', isa => 'ArrayRef[Str]' );

has before_filter_config  => ( is => 'rw' );
has after_filter_config  => ( is => 'rw' );

{
    my %singleton;
    sub new {
        my $class = shift;
        return $singleton{$class} //= $class->_new();
    }
}

sub _new {
    my $class = shift;
    return $class->SUPER::new({ dispatch_table => {}, math_table => [] });
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
    if ($c->metadata && $c->metadata->{usemath} eq "true") {
      ## Markdown が数式を処理しないように math_table へ退避し
      ### 目印で置き換えて after_filter で戻す

      my @math_table = ();

      ## ブロック数式
      $in =~ s{(\$\$(?:[^\$]|\\\$)+\$\$)}{
        push @math_table, $1;
        "◆数式:D-$#math_table◆";
      }xegm;

      ## インライン数式
      my @lines = split /\n/, $in;
      s{(\$(?:[^\$]|\\\$)+\$)}{
        push @math_table, $1;
        "◆数式:I-$#math_table◆";
      }xeg foreach @lines;
      $in = join "\n", @lines;

      $self->math_table(\@math_table);
    }
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
            $out =~ s/\Q$k/$config->{$k}/eg;
        }
    }
    if ($c->metadata && $c->metadata->{usemath} eq "true") {
      ## math_table へ退避した数式を戻す
      $out =~ s{◆数式:[DI]-(\d+)◆}{
        $self->math_table->[$1];
      }xeg;
    }
    return $out;
}

1;
