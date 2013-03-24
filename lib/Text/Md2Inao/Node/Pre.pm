package Text::Md2Inao::Node::Pre;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

use List::Util 'max';
use Text::Md2Inao::Logger;
use Text::Md2Inao::Util;

sub to_inao {
    my $self = shift;
    $self->context->is_code_block(1);

    my $code = $self->element->find('code');
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
        if ($max > $self->context->max_list_length) {
            log warn => "リストは" . $self->context->max_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
        }
    }
    else {
        if ($max > $self->context->max_inline_list_length) {
            log warn => "本文埋め込みリストは" . $self->context->max_inline_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
        }
    }

    # コード内コメント
    # my $in_footnote;
    if ($text =~ m!\(注:! or $self->context->in_footnote) {
        $text = $self->context->replace_note_parenthesis($text, $comment_label);
    }

    # コード内強調
    $text =~ s!\*\*(.+?)\*\*!◆cmd-b/◆$1◆/cmd-b◆!g;

    # コード内イタリック
    $text =~ s!\___(.+?)\___!◆i-j/◆$1◆/i-j◆!g;
    chomp $text;

    $self->context->is_code_block(0);

    return <<EOF;
◆$list_label/◆
$text
◆/$list_label◆
EOF
}

1;
