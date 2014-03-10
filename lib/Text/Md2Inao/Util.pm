package Text::Md2Inao::Util;
use utf8;
use strict;
use warnings;

use Exporter::Lite;
use Unicode::EastAsianWidth;

use Text::Md2Inao::Logger;

our @EXPORT = qw/
    to_list_style
    visual_length
    replace_note_parenthesis
    fallback_to_html
    Dumper
/;

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
    local $_ = shift;
    my $ret = 0;
    while (/(?:(\p{InFullwidth}+)|(\p{InHalfwidth}+))/g) { $ret += ($1 ? length($1)*2 : length($2)) }
    return $ret;
}

# 脚注記法への変換
# (注: ... ) → ◆注/◆ ... ◆/注◆
# 入れ子の括弧も考慮る
sub replace_note_parenthesis {
    my ($context, $line, $label) = @_;
    my @end_pos;

    ## 1文字ずつ追って括弧の対応を調べる
    my @char = split //, $line;
    my $level  = 0;
    my $index  = 0;

    for (@char) {
        if ($_ eq '(') {
            if ($char[$index + 1] eq '注' and $char[$index + 2] eq ':') {
                $context->in_footnote(1);
            }
            if ($context->in_footnote) {
                $level++;
            }
        }
        if ($_ eq ')') {
            if ($context->in_footnote) {
                ## $in_footnote && $level == 0
                ## (注: _italic_ ) とかで中で $line が分断されたケース
                if ($level == 0) {
                    push @end_pos, $index;
                    $context->in_footnote(0);
                }
                ## 普通に (注: の対応括弧が見つかった
                elsif ($level == 1) {
                    push @end_pos, $index;
                    $level = 0;
                    $context->in_footnote(0);
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

sub fallback_to_html {
    my $h = shift;
    log warn => sprintf "HTMLタグは `<%s>` もしくは実体参照でエスケープしてください。しない場合の出力は不定です", $h->tag;
    return $h->as_HTML('', '', {});
}

sub Dumper {
    require Data::Recursive::Encode;
    require Data::Dumper;
    my $dd = Data::Dumper->new([map { Data::Recursive::Encode->encode_utf8($_) } @_]);
    $dd->Indent(1);
    $dd->Useqq(0);
    $dd->Sortkeys(1);
    $dd->Terse(1);
    return $dd->Dump();
}

1;
