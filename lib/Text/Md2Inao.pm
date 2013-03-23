package Text::Md2Inao;
use utf8;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;
use Class::Accessor::Fast qw/antlers/;
use Encode;
use HTML::TreeBuilder;
use Text::Markdown 'markdown';
use Unicode::EastAsianWidth;
use Module::Load;

use Text::Md2Inao::Util;
use Text::Md2Inao::Logger;

use Exporter::Lite;
our @EXPORT = qw/inode/;

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

has is_inline => (is => 'rw');
has in_footnote => (is => 'rw');

sub is_block {
    !shift->is_inline
}

sub parse {
    my ($self, $in) = @_;
    return $self->to_inao($in);
}

# 脚注記法への変換
# (注: ... ) → ◆注/◆ ... ◆/注◆
# 入れ子の括弧も考慮る
sub replace_note_parenthesis {
    my ($self, $line, $label) = @_;
    my @end_pos;

    ## 1文字ずつ追って括弧の対応を調べる
    my @char = split //, $line;
    my $level  = 0;
    my $index  = 0;

    for (@char) {
        if ($_ eq '(') {
            if ($char[$index + 1] eq '注' and $char[$index + 2] eq ':') {
                $self->in_footnote(1);
            }
            if ($self->in_footnote) {
                $level++;
            }
        }
        if ($_ eq ')') {
            if ($self->in_footnote) {
                ## $in_footnote && $level == 0
                ## (注: _italic_ ) とかで中で $line が分断されたケース
                if ($level == 0) {
                    push @end_pos, $index;
                    $self->in_footnote(0);
                }
                ## 普通に (注: の対応括弧が見つかった
                elsif ($level == 1) {
                    push @end_pos, $index;
                    $level = 0;
                    $self->in_footnote(0);
                }

                ## (注: の中に入れ子になっている括弧の対応括弧が見つかった
                else {
                    $level--;
                }
            }
        }
        $index++;
    }

    ## 前から置換してくと置換後文字のが文字数多くて位置がずれるので後ろから
    for my $pos (reverse @end_pos) {
        substr $line, $pos, 1, "◆/$label◆";
    }

    $line =~ s!\(注:!◆$label/◆!g;
    return $line;
}

sub parse_inline {
    my $self = shift;
    my $elem = shift;
    my $is_special_italic = shift;
    my $ret = '';

    $self->is_inline(1);

    for my $inline ($elem->content_list) {
        if (ref $inline eq '') {
            if ($inline =~ m!\(注:! or $self->in_footnote) {
                $inline = $self->replace_note_parenthesis($inline, '注');
            }

            # 改行を取り除く
            $inline =~ s/(\n|\r)//g;

            # キャプション
            if ($inline =~ s!^●(.+?)::(.+)!●$1\t$2!) {
                $inline =~ s!\[(.+)\]$!\n$1!;
            }

            # リストスタイル文字の変換
            $inline = to_list_style($inline);

            $ret .= $inline;
        }
        elsif ($inline->tag eq 'em') {
            $ret .= inode($self, $inline, { special_italic => $is_special_italic })->to_inao;
        }
        else {
            $ret .= inode($self, $inline)->to_inao;
        }
    }

    $self->is_inline(0);
    return $ret;
}

sub to_html_tree {
    my $text = shift;

    $text = prepare_text_for_markdown($text);

    ## Work Around: Text::Markdown が flagged string だと一部 buggy なので encode してから渡している
    my $html = decode_utf8 markdown(encode_utf8 $text);
    $html = prepare_html_for_inao($html);

    my $tree = HTML::TreeBuilder->new;
    $tree->no_space_compacting(1);
    $tree->parse_content(\$html);
}

sub prepare_text_for_markdown {
    my $text = shift;

    ## Work Around: 先頭空白は字下げとみなし全角空白に置き換える (issue #4)
    $text =~ s/^[ ]{1,3}([^ ])/　$1/mg;

    ## Work Around: リストの後にコードブロックが続くとだめな問題 (issue #6)
    $text =~ s![-*+] (.*?)\n\n    !- $1\n\n　\n\n    !g;

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

sub to_inao {
    my ($self, $text, $is_column) = @_;

    my $tree = to_html_tree($text);
    my $inao = q[];
    my $body = $tree->find('body');

    for my $elem ($body->content_list) {
        if ($elem->tag =~ /^h(\d+)/) {
            my $level = $1;

            $inao .= '■' x $level;
            $inao .= $elem->as_trimmed_text;
            $inao .= "\n";
        }
        elsif ($elem->tag eq 'p') {
            my $p = $self->parse_inline($elem, $is_column);

            if ($p !~ /^[\s　]+$/) {
                $inao .= "$p\n";
            }
        }
        elsif ($elem->tag eq 'div' and $elem->attr('class') eq 'column') {
            # HTMLとして取得してcolumn自信のdivタグを削除
            my $html = $elem->as_HTML('');
            $html =~ s/^<div.+?>//;
            $html =~ s/<\/div>$//;

            $inao .= "◆column/◆\n";
            $inao .= $self->to_inao($html, 1);
            $inao .= "◆/column◆\n";
        }
        else {
            $inao .= inode($self, $elem)->to_inao;
        }
    }

    return $inao;
}

use Text::Md2Inao::Node::Unknown;
use Errno ();

## Factory Method
sub inode {
    my ($p, $h, $args) = @_;
    $args ||= {};

    my $pkg = sprintf "Text::Md2Inao::Node::%s", ucfirst $h->tag;
    eval {
        load $pkg;
    };
    if ($@) {
        if ($! ==  Errno::ENOENT) {
            return Text::Md2Inao::Node::Unknown->new({ context => $p, element => $h });
        }
    } else {
        return $pkg->new({ context => $p, element => $h, %$args });
    }
}

1;

=head1 NAME

Text::Md2Inao - Convert markdown text to Inao-format

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Naoya Ito E<lt>i.naoya@gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
