package Text::Md2Inao;
use utf8;
use strict;
use warnings;

our $VERSION = '0.11';

use Carp;
use Class::Accessor::Fast qw/antlers/;
use Encode;
use HTML::TreeBuilder;
use Text::Markdown::Hoedown;

use Text::Md2Inao::Director;
use Text::Md2Inao::Builder::Inao;

# デフォルトのリストスタイル
# disc:   黒丸
# square: 四角
# circle: 白丸
# alpha:  アルファベット
has default_list => ( is => 'rw', isa => 'Str' );

# リストの文字数上限
# WEB+DB PRESSの場合、リストは、1行63桁（文字）まで
# 書籍の場合、リストは1行69桁（文字）まで
has max_list_length => ( is => 'rw', isa => 'Num' );

# 本文埋め込みリストの文字数上限
# WEB+DB PRESSの場合、本文リストは1行55桁（文字）まで
# 書籍の場合、本文リストは1行73桁（文字）まで
has max_inline_list_length => ( is => 'rw', isa => 'Num' );

# 空行のスタイル
# half | full
has blank_style => ( is => 'rw', isa => 'Str' );

# コンテキスト判定のための属性
has in_footnote    => (is => 'rw', isa => 'Bool');
has in_column      => (is => 'rw', isa => 'Bool');
has in_code_block  => (is => 'rw', isa => 'Bool');
has in_list        => (is => 'rw', isa => 'Bool');
has in_quote_block => (is => 'rw', isa => 'Bool');

has director => ( is => 'rw' );
has builder  => ( is => 'rw' );
has metadata => ( is => 'rw' );

sub use_special_italic {
    my $self = shift;
    return 1 if $self->in_column;
    return 1 if $self->in_code_block;
    return 1 if $self->in_list;
    return 1 if $self->in_quote_block;
    return;
}

sub prepare_text_for_markdown {
    my $text = shift;

    ## Work Around: 先頭空白は字下げとみなし全角空白に置き換える (issue #4)
    $text =~ s/^[ ]{1,3}([^ <])/　$1/mg;

    ## Work Around: リストの後にコードブロックが続くとだめな問題 (issue #6)
    $text =~ s!([-*+] .*?)\n\n    !$1\n\n　\n\n    !g;

    return $text;
}

sub prepare_html_for_inao {
    my $html = shift;
    ## Work Around: リスト周りと inao 記法の相性が悪い
    # see also: t/07_list.t
    $html =~ s!<li><p>(.+)</p></li>\n!<li>$1</li>\n!g;

    ## 段落切り替えの意図が見えるのにそうならないケースを補正 (issue #8)
    $html =~ s!<p>(.*)\n　!<p>$1</p>\n<p>　!g;
    return $html;
}

sub to_html_tree {
    my $text = shift;

    $text = prepare_text_for_markdown($text);
    my $html = markdown($text,
        extensions => HOEDOWN_EXT_FENCED_CODE,
    );
    $html = prepare_html_for_inao($html);

    my $tree = HTML::TreeBuilder->new;
    $tree->no_space_compacting(1);
    $tree->parse_content(\$html);
}

sub parse_element {
    my ($self, $elem) = @_;
    my @out = map { $self->director->process($self, $_) } $elem->content_list;
    return join '', @out;
}

sub parse_markdown {
    my ($self, $md) = @_;
    return $self->parse_element(to_html_tree($md)->find('body'));
}

sub parse_metadata {
    my ($self, $in) = @_;
    if ($in =~ /^[\w\(\)]+?:.+\n/m) {
        my $has_metadata;
        my @lines = split /\n/, $in;
        my %meta;

        for (@lines) {
            if (m/^([\w\(\)]+?):(.+)/) {
                my ($k, $v) = ($1, $2);
                $v =~ s/^\s+//;
                $v =~ s/\s+$//;
                $meta{lc $k} = $v;
                next;
            }
            if ($_ eq '') { # 区切りの空行
                $has_metadata = 1;
                $self->metadata(\%meta);
                last;
            }
            else {
                last;
            }
        }
        if ($has_metadata) {
            $in =~ s/^.+?\n\n//s;
            return $in;
        }
    }
    return $in;
}

sub parse {
    my ($self, $md) = @_;
    my $builder  = $self->builder || Text::Md2Inao::Builder::Inao->new;
    $self->director( Text::Md2Inao::Director->new($builder) );
    $md = $self->parse_metadata($md);
    $md = $self->director->process_before_filter($self, $md);
    my $out = $self->parse_markdown($md);
    return $self->director->process_after_filter($self, $out);
}

1;

=head1 NAME

Text::Md2Inao - Convert markdown text to Inao-format

=head1 SYNOPSIS

    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
    });

    print encode_utf8 $p->parse($markdown_text);

=head1 DESCRIPTION

This is a text converter for WEB+DB PRESS articles.

=head1 AUTHOR

Naoya Ito E<lt>i.naoya@gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
