package Text::Md2Inao::Node::Text;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

use Text::Md2Inao::Util;

sub to_inao {
    my $self = shift;
    my $text = $self->element;

    if ($text =~ m!\(注:! or $self->context->in_footnote) {
        $text = $self->context->replace_note_parenthesis($text, '注');
    }

    # 改行を取り除く
    $text =~ s/(\n|\r)//g;

    # キャプション
    if ($text =~ s!^●(.+?)::(.+)!●$1\t$2!) {
        $text =~ s!\[(.+)\]$!\n$1!;
    }

    # リストスタイル文字の変換
    $text = to_list_style($text);

    return $text;
}

1;
