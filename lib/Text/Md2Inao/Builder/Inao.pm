package Text::Md2Inao::Builder::Inao;
use utf8;
use strict;
use warnings;

use List::Util qw/max/;
use Tie::IxHash;

use Text::Md2Inao::Logger;
use Text::Md2Inao::Util;

use parent qw/Text::Md2Inao::Builder/;

use Text::Md2Inao::Builder::DSL;

tie my %meta2label, "Tie::IxHash",
    title                => 'タイトル',
    subtitle             => 'キャッチ',
    author               => '著者',
    'author(romaji)'     => '著者（ローマ字）',
    supervisor           => '監修',
    'supervisor(romaji)' => '監修（ローマ字）',
    url                  => 'URL',
    mail                 => 'mail',
    github               => 'Github',
    twitter              => 'Twitter',
;

sub prepend_metadata {
    my ($self, $c, $text) = @_;
    if ($c->metadata) {
        my @lines;
        if (my $chapter = $c->metadata->{chapter}) {
            push @lines, sprintf "章番号：第%d章", $chapter;
        }

        if (my $serial = $c->metadata->{serial}) {
            push @lines, sprintf "連載回数：第%d回", $serial;
        }

        for (keys %meta2label) {
            if (my $value = $c->metadata->{$_}) {
                push @lines, sprintf "%s：%s", $meta2label{$_}, $value;
            }
        }
        $text = join "\n", @lines, $text;
    }
    return $text;
}

sub after_filter {
    my ($self, $c, $text) = @_;
    $text = $self->prepend_metadata($c, $text);
    return $self->SUPER::after_filter($c, $text);
}

case default => sub {
    my ($c, $h) = @_;
    fallback_to_html($h);
};

case text => sub {
    my ($c, $text) = @_;
    if ($text =~ m!\(注:! or $c->in_footnote) {
        $text = replace_note_parenthesis($c, $text, '注');
    }

    # 各行の余計な先頭空白を取り除く (全角は字下げ指定なので残す)
    $text =~ s/^[ ]+//mg;

    # 改行を取り除く
    $text =~ s/(\n|\r)//g;
    # キャプション
    if ($text =~ s!^●(.+?)::(.+)!●$1\t$2!) {
        $text =~ s!\[(.+)\]$!\n$1!;
    }
    # リストスタイル文字の変換
    $text = to_list_style($text);
    return $text;
};

case a => sub {
    my ($c, $h) = @_;
    my $url   = $h->attr('href');
    my $title = $h->as_trimmed_text;
    if ($url and $title) {
        return sprintf "%s◆注/◆%s◆/注◆", $title, $url;
    } else {
        return fallback_to_html($h);
    }
};

case blockquote => sub {
    my ($c, $h) = @_;

    $c->in_quote_block(1);
    my $blockquote = $c->parse_element($h);
    $c->in_quote_block(0);

    chomp $blockquote;

    return <<EOF;
◆quote/◆
$blockquote
◆/quote◆
EOF
};

case code => sub {
    my ($c, $h) = @_;
    sprintf(
        "◆cmd/◆%s◆/cmd◆" ,
        $h->as_trimmed_text
    );
};

case div => sub {
    my ($c,  $h) = @_;
    my $out = '';

    if ($h->attr('class') eq 'column') {
        $c->in_column(1);

        # HTMLとして取得してcolumn自信のdivタグを削除
        my $html = $h->as_HTML('');
        $html =~ s/^<div.+?>//;
        $html =~ s/<\/div>$//;

        $out .= "◆column/◆\n";
        $out .= $c->parse_markdown($html);
        $out .= "◆/column◆\n";

        $c->in_column(0);
    } else {
        $out .= fallback_to_html($h);
    }

    return $out;
};

case dl => sub {
    my ($c, $h) = @_;
    my $out = '';
    for ($h->descendants) {
        if ($_->tag eq 'dt') {
            $out .= sprintf "・%s\n", $c->parse_element($_);
        } elsif ($_->tag eq 'dd') {
            $out .= sprintf "・・%s\n", $c->parse_element($_);
        }
    }
    return $out;
};

case em => sub {
    my ($c, $h) = @_;
    my $ret;
    $ret .= $c->use_special_italic ? '◆i-j/◆' : '◆i/◆';
    $ret .= $h->as_trimmed_text;
    $ret .= $c->use_special_italic ? '◆/i-j◆' : '◆/i◆';
    return $ret;
};

case "h1, h2, h3, h4, h5" => sub {
    my ($c, $h) = @_;
    my $out = '';
    if ($h->tag =~ /^h(\d+)$/) {
        my $level = $1;
        $out .= '■' x $level;
        $out .= $h->as_trimmed_text;
        $out .= "\n";
    }
    return $out;
};

case img => sub {
    my ($c, $h) = @_;
    $c->{img_number} += 1;
    return sprintf (
        "●図%d\t%s\n%s\n",
        $c->{img_number},
        $h->attr('alt') || $h->attr('title'),
        $h->attr('src')
    );
};

case kbd => sub {
    my ($c, $h) = @_;
    sprintf "%s▲" ,$h->as_trimmed_text;
};

case ol => sub {
    my ($c, $h) = @_;
    my $out = '';
    my $list_style = $h->attr('class') || $c->default_list;
    my $s = substr $list_style, 0, 1;
    my $i = 0;
    for my $list ($h->find('li')) {
        $out .= to_list_style((sprintf '(%s%d)', $s, ++$i) . $c->parse_element($list)) . "\n";
    }
    return $out;
};

case p => sub {
    my ($c, $h) = @_;
    my $p = $c->parse_element($h);
    if ($p !~ /^[\s　]+$/) {
        return "$p\n";
    }
};

case pre => sub {
    my ($c, $h) = @_;
    $c->in_code_block(1);

    my $code = $h->find('code');
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
        if ($max > $c->max_list_length) {
            log warn => "リストは" . $c->max_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
        }
    }
    else {
        if ($max > $c->max_inline_list_length) {
            log warn => "本文埋め込みリストは" . $c->max_inline_list_length . "文字まで！(現在${max}使用):\n$text\n\n";
        }
    }

    # コード内コメント
    # my $in_footnote;
    if ($text =~ m!\(注:! or $c->in_footnote) {
        $text = replace_note_parenthesis($c, $text, $comment_label);
    }

    # コード内強調
    $text =~ s!\*\*(.+?)\*\*!◆cmd-b/◆$1◆/cmd-b◆!g;

    # コード内イタリック
    $text =~ s!\___(.+?)\___!◆i-j/◆$1◆/i-j◆!g;
    chomp $text;

    $c->in_code_block(0);

    return <<EOF;
◆$list_label/◆
$text
◆/$list_label◆
EOF
};

case span => sub {
    my ($c, $h) = @_;
    if ($h->attr('class') eq 'red') {
        return sprintf "◆red/◆%s◆/red◆",    $h->as_trimmed_text;
    }
    elsif ($h->attr('class') eq 'ruby') {
        my $ruby = $h->as_trimmed_text;
        $ruby =~ s!(.+)\((.+)\)!◆ルビ/◆$1◆$2◆/ルビ◆!;
        return $ruby;
    }
    elsif ($h->attr('class') eq 'symbol') {
        return sprintf "◆%s◆",$h->as_trimmed_text;
    }
    else {
        return fallback_to_html($h);
    }
};

case table => sub {
    my ($c, $h) = @_;
    my $out = '';
    my $summary = $h->attr('summary') || '';
    $summary =~ s!(.+?)::(.+)!●$1\t$2\n!;
    $out .= "◆table/◆\n";
    $out .= $summary;
    $out .= "◆table-title◆";
    for my $table ($h->find('tr')) {
        for my $item ($table->find('th')) {
            $out .= $item->as_trimmed_text;
            $out .= "\t";
        }
        for my $item ($table->find('td')) {
            $out .= $item->as_trimmed_text;
            $out .= "\t";
        }
        chop($out);
        $out .= "\n"
    }
    $out .= "◆/table◆\n";
    return $out;
};

case strong => sub {
    my ($c, $h) = @_;
    return sprintf(
        "◆b/◆%s◆/b◆",
        $h->as_trimmed_text
    );
};

case ul => sub {
    my ($c, $h) = @_;
    if ($c->in_list) {
        my $ret = "\n";
        for ($h->content_list) {
            if ($_->tag eq 'li') {
                $ret .= sprintf "＊・%s\n", $c->parse_element($_);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($h->content_list) {
            $c->in_list(1);
            $ret .= '・' . $c->parse_element($list) . "\n";
            $c->in_list(0);
        }
        return $ret;
    }
};

case hr => sub {
    my ($c, $h) = @_;
    return "=-=-=\n";
};

1;
