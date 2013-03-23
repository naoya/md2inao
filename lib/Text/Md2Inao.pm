package Text::Md2Inao;
use utf8;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;
use Class::Accessor::Fast qw/antlers/;
use Encode;
use HTML::TreeBuilder;
use List::Util 'max';
use Text::Markdown 'markdown';
use Unicode::EastAsianWidth;

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

sub parse {
    my ($self, $in) = @_;
    $self->{img_number} = 0;
    return $self->to_inao($in);
}

# 本文中に（◯1）や（1）など、リストを参照するときの形式に変換する
# 「リスト1.1(c1)を見てください」
# -> 
# 「リスト1.1（◯1）を見てください」となる
#
# (d1) -> （1）   # desc
# (c1) -> （◯1） # circle
# (s1) -> ［1］   # square
# (a1) -> （a）   # alpha
#
# エスケープも可能
# (\d1) -> (d1)
# (\c1) -> (c1)
sub to_list_style {
    my $text = shift;

    # convert
    $text =~ s/\(d(\d+)\)/（$1）/g;
    $text =~ s/\(c(\d+)\)/（○$1）/g;
    $text =~ s/\(s(\d+)\)/［$1］/g;
    $text =~ s/\(a(\d+)\)/'（' . chr($1 + 96)  . '）'/ge;

    # escape
    $text =~ s/\(\\([dcsa]?\d+)\)/($1)/g;

    return $text;
}

# 文字幅計算
# http://d.hatena.ne.jp/tokuhirom/20070514/1179108961
sub visual_length {
    local $_ = Encode::decode_utf8(shift);
    my $ret = 0;
    while (/(?:(\p{InFullwidth}+)|(\p{InHalfwidth}+))/g) { $ret += ($1 ? length($1)*2 : length($2)) }
    return $ret;
}

# 脚注記法への変換
# (注: ... ) → ◆注/◆ ... ◆/注◆
# 入れ子の括弧も考慮る
sub replace_note_parenthesis {
    my ($line, $label, $in_footnote) = @_;
    my @end_pos;

    ## 1文字ずつ追って括弧の対応を調べる
    my @char = split //, $line;
    my $level  = 0;
    my $index  = 0;

    for (@char) {
        if ($_ eq '(') {
            if ($char[$index + 1] eq '注' and $char[$index + 2] eq ':') {
                $$in_footnote++;
            }
            if ($$in_footnote) {
                $level++;
            }
        }
        if ($_ eq ')') {
            if ($$in_footnote) {
                ## $in_footnote && $level == 0
                ## (注: _italic_ ) とかで中で $line が分断されたケース
                if ($level == 0) {
                    push @end_pos, $index;
                    $$in_footnote--;
                }
                ## 普通に (注: の対応括弧が見つかった
                elsif ($level == 1) {
                    push @end_pos, $index;
                    $level = 0;
                    $$in_footnote--;
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
    my $in_footnote;

    for my $inline ($elem->content_list) {
        if (ref $inline eq '') {
            if ($inline =~ m!\(注:! or $in_footnote) {
                $inline = replace_note_parenthesis($inline, '注', \$in_footnote);
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
        elsif ($inline->tag eq 'a') {
            my $url   = $inline->attr('href');
            my $title = $inline->as_trimmed_text;
            if ($url and $title) {
                $ret .= sprintf "%s◆注/◆%s◆/注◆", $title, $url;
            } else {
                $ret .= fallback_to_html($inline)
            }
        }
        elsif ($inline->tag eq 'img') {
            my $url   = $inline->attr('src');
            my $title = $inline->attr('alt') || $inline->attr('title');
            $ret .= sprintf(
                "●図%d\t%s\n%s\n",
                ++$self->{img_number},
                $title,
                $url,
            );
        }
        elsif ($inline->tag eq 'code') {
            $ret .= inode($inline)->to_inao;
        }
        elsif ($inline->tag eq 'strong') {
            $ret .= '◆b/◆';
            $ret .= $inline->as_trimmed_text;
            $ret .= '◆/b◆';
        }
        elsif ($inline->tag eq 'em') {
            $ret .= inode($inline, { special_italic => $is_special_italic })->to_inao;
        }
        elsif ($inline->tag eq 'kbd') {
            $ret .= inode($inline)->to_inao;

        }
        elsif ($inline->tag eq 'ul') {
            ## parse_inline の中の ul は入れ子の ul だと決め打ちで平気だろうか?
            $ret .= "\n";
            for ($inline->content_list) {
                if ($_->tag eq 'li') {
                    $ret .= sprintf "＊・%s\n", $self->parse_inline($_, 1);
                }
            }
            chomp $ret;
        }
        elsif ($inline->tag eq 'span') {
            $ret .= inode($inline)->to_inao;
        } else {
            ## 要警告
            $ret .= fallback_to_html($inline);
        }
    }
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
        elsif ($elem->tag eq 'pre') {
            my $code = $elem->find('code');
            my $text = $code ? $code->as_text : '';
            my $list_label = 'list';
            my $comment_label = 'comment';

            # キャプション
            $text =~ s!●(.+?)::(.+)!●$1\t$2!g;

            # 「!!! cmd」で始まるコードブロックはコマンドライン（黒背景）
            if ($text =~ /!!!(\s+)?cmd/) {
                $text =~ s/.+?\n//;
                $list_label .= '-white';
                $comment_label .= '-white';
            }

            # リストスタイル
            $text = to_list_style($text);

            # 文字数カウント
            my $max = max(map { visual_length($_) } split /\r?\n/, $text);
            if ($text =~ /^●/) {
                if ($max > $self->max_list_length) {
                    log warn => "リストは" . $self->max_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
                }
            }
            else {
                if ($max > $self->max_inline_list_length) {
                    log warn => "本文埋め込みリストは" . $self->max_inline_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
                }
            }

            # コード内コメント
            my $in_footnote;
            if ($text =~ m!\(注:! or $in_footnote) {
                $text = replace_note_parenthesis($text, $comment_label, \$in_footnote);
            }

            # コード内強調
            $text =~ s!\*\*(.+?)\*\*!◆cmd-b/◆$1◆/cmd-b◆!g;

            # コード内イタリック
            $text =~ s!\___(.+?)\___!◆i-j/◆$1◆/i-j◆!g;

            $inao .= "◆$list_label/◆\n";
            $inao .= $text;
            $inao .= "◆/$list_label◆\n";
        }
        elsif ($elem->tag eq 'ul') {
            for my $list ($elem->content_list) {
                $inao .= '・' . $self->parse_inline($list, 1) . "\n";
            }
        }
        elsif ($elem->tag eq 'ol') {
            my $list_style = $elem->attr('class') || $self->default_list;
            my $s = substr $list_style, 0, 1;
            my $i = 0;
            for my $list ($elem->find('li')) {
                $inao .=
                    to_list_style((sprintf('(%s%d)', $s, ++$i)) .
                    $self->parse_inline($list, 1)) . "\n";
            }
        }
        elsif ($elem->tag eq 'dl') {
            for ($elem->descendants) {
                if ($_->tag eq 'dt') {
                    $inao .= sprintf "・%s\n", $self->parse_inline($_);
                }
                elsif ($_->tag eq 'dd') {
                    $inao .= sprintf "・・%s\n", $self->parse_inline($_);
                }
            }
        }
        elsif ($elem->tag eq 'table') {
            my $summary = $elem->attr('summary') || '';
            $summary =~ s!(.+?)::(.+)!●$1\t$2\n!;
            $inao .= "◆table/◆\n";
            $inao .= $summary;
            $inao .= "◆table-title◆";
            for my $table ($elem->find('tr')) {
                for my $item ($table->find('th')){
                    $inao .= $item->as_trimmed_text;
                    $inao .= "\t";
                }
                for my $item ($table->find('td')){
                    $inao .= $item->as_trimmed_text;
                    $inao .= "\t";
                }
                chop($inao);
                $inao .= "\n"
            }
            $inao .= "◆/table◆\n";
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
        elsif ($elem->tag eq 'blockquote') {
            my $blockquote = '';
            for my $p ($elem->content_list) {
                $blockquote = $self->parse_inline($p, 1);
            }
            $blockquote =~ s/(\s)//g;
            $inao .= "◆quote/◆\n";
            $inao .= $blockquote;
            $inao .= "\n◆/quote◆\n";
        }
        else {
            $inao .= fallback_to_html($elem) . "\n";
        }
    }

    return $inao;
}

sub fallback_to_html {
    my $element = shift;
    log warn => sprintf "HTMLタグは `<%s>` でエスケープしてください。しない場合の出力は不定です", $element->tag;
    return $element->as_HTML('', '', {});
}

use Text::Md2Inao::Node::Span;
use Text::Md2Inao::Node::Kbd;
use Text::Md2Inao::Node::Code;
use Text::Md2Inao::Node::Em;
use Text::Md2Inao::Node::Strong;

sub inode {
    my ($h, $args) = @_;
    $args ||= {};

    if ($h->tag eq 'span') {
        return Text::Md2Inao::Node::Span->new({ element => $h });
    }

    if ($h->tag eq 'kbd') {
        return Text::Md2Inao::Node::Kbd->new({ element => $h });
    }

    if ($h->tag eq 'code') {
        return Text::Md2Inao::Node::Code->new({ element => $h });
    }

    if ($h->tag eq 'em') {
        return Text::Md2Inao::Node::Em->new({ element => $h, %$args });
    }

    if ($h->tag eq 'strong') {
        return Text::Md2Inao::Node::Strong->new({ element => $h });
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
