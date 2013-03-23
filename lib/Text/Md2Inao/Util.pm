package Text::Md2Inao::Util;
use utf8;
use strict;
use warnings;

use Exporter::Lite;
use Unicode::EastAsianWidth;

our @EXPORT = qw/to_list_style visual_length/;

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

1;
