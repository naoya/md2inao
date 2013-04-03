## THIS MODULE IS STILL UNDER DEVELOPMENT
package Text::Md2Inao::Builder::InDesign;
use utf8;
use strict;
use warnings;

use Text::Md2Inao::Logger;
use Text::Md2Inao::Util;

use Text::Md2Inao::Builder;
use parent qw/Text::Md2Inao::Builder/;

use List::Util qw/max/;

sub list_marker {
    my ($style, $i) = @_;

    if ($style eq 'disc') {
        my $code = 0x2776 - 1;
        return sprintf "<CharStyle:丸文字><%x><CharStyle:>", $code + $i;
    }

    if ($style eq 'circle') {
        my $code = 0x2460 - 1;
        return sprintf "<CharStyle:丸文字><%x><CharStyle:>", $code + $i;
    }

    if ($style eq 'square') {
        return sprintf "<cTypeface:B><cFont:A-OTF ゴシックMB101 Pro><cotfcalt:0><cotfl:nalt,7>%d<cTypeface:><cFont:><cotfcalt:><cotfl:>", $i;
    }

    if ($style eq 'alpha') {
        return sprintf "<CharStyle:丸文字><cLigatures:0><cOTFContAlt:0><cOTFeatureList:nalt,3>%s<cLigatures:><cOTFContAlt:><cOTFeatureList:><CharStyle:>", chr($i + 96);
    }
}

sub replace_list_maker {
    my $text = shift;

    # convert
    $text =~ s/\(d(\d+)\)/list_marker('disc', $1)/eg;
    $text =~ s/\(c(\d+)\)/list_marker('circle', $1)/eg;
    $text =~ s/\(s(\d+)\)/list_marker('square', $1)/eg;
    $text =~ s/\(a(\d+)\)/list_marker('alpha', $1)/eg;

    # escape
    $text =~ s/\(\\([dcsa]?\d+)\)/($1)/g;

    return $text;
}

case default => sub {
    my ($c, $h) = @_;
    $h->as_HTML('', '', {});
};

case text => sub {
    my ($c, $text) = @_;
    if ($text =~ m!\(注:! or $c->in_footnote) {
        $text = replace_note_parenthesis($c, $text, '注');
        $text =~ s!◆注/◆!<fnStart:><pstyle:注釈>!g;
        $text =~ s!◆/注◆!<fnEnd:><cstyle:>!g;
    }
    # 改行を取り除く
    $text =~ s/(\n|\r)//g;
    # キャプション
    if ($text =~ s!^●(.+?)::(.+)!●$1\t$2!) {
        $text =~ s!\[(.+)\]$!\n$1!;
    }

    return replace_list_maker $text;
};

case "h1" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:大見出し>%s\n", $h->as_trimmed_text;
};

case "h2" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:中見出し>%s\n", $h->as_trimmed_text;
};

case "h3" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:小見出し>%s\n", $h->as_trimmed_text;
};

case "h4" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:コラムタイトル>%s\n", $h->as_trimmed_text;
};

case "h5" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:コラム小見出し>%s\n", $h->as_trimmed_text;
};

case strong => sub {
    my ($c, $h) = @_;
    return sprintf "<CharStyle:太字>%s<CharStyle:>", $h->as_trimmed_text;
};

case em => sub {
    my ($c, $h) = @_;
    my $ret;
    $ret .= $c->use_special_italic ? '<CharStyle:イタリック（変形斜体）>' : '<CharStyle:イタリック（変形斜体）>';
    $ret .= $h->as_trimmed_text;
    $ret .= '<CharStyle:>';
    return $ret;
};

case code => sub {
    my ($c, $h) = @_;
    return sprintf "<CharStyle:コマンド>%s<CharStyle:>", $h->as_trimmed_text;
};

case p => sub {
    my ($c, $h) = @_;
    my $text = $c->parse_element($h);
    if ($text !~ /^[\s　]+$/) {
        if ($text =~ /^<ParaStyle:キャプション>/) { ## Dirty Hack...
            return $text;
        } else {
            my $label = $c->in_column ? 'コラム本文' : '本文';
            return sprintf "<ParaStyle:%s>%s\n", $label, $text;
        }
    }
};

## FIXME: https://github.com/inao/idtagreplacer/blob/master/sample/tagconf.xml の自由置換設定を反映させる必要
case kbd => sub {
    my ($c, $h) = @_;
    sprintf "<cFont:Key Mother>%s<cFont:>" ,$h->as_trimmed_text;
};

case span => sub {
    my ($c, $h) = @_;
    if ($h->attr('class') eq 'red') {
        return sprintf "<CharStyle:赤字>%s<CharStyle:>", $h->as_trimmed_text;
    }
    elsif ($h->attr('class') eq 'ruby') {
        my $ruby = $h->as_trimmed_text;
        $ruby =~ s!(.+)\((.+)\)!<cr:1><crstr:$2><cmojir:0>$1<cr:><crstr:><cmojir:>!;
        return $ruby;
    }

    ## FIXME
    elsif ($h->attr('class') eq 'symbol') {
        return sprintf "◆%s◆",$h->as_trimmed_text;
    }

    else {
        return fallback_to_html($h);
    }
};

case blockquote => sub {
    my ($c, $h) = @_;
    $c->in_quote_block(1);
    my $blockquote = '';
    for ($h->content_list) {
        $blockquote .= $c->parse_element($_);
    }
    $blockquote =~ s/(\s)//g;
    $c->in_quote_block(0);

    return <<EOF;
<ParaStyle:引用>
<ParaStyle:引用>$blockquote
EOF
};

case div => sub {
    my ($c,  $h) = @_;

    if ($h->attr('class') eq 'column') {
        $c->in_column(1);

        # HTMLとして取得してcolumn自信のdivタグを削除
        my $html = $h->as_HTML('');
        $html =~ s/^<div.+?>//;
        $html =~ s/<\/div>$//;

        my $column = $c->parse($html);
        $c->in_column(0);
        return sprintf "<ParaStyle:コラム本文>\n%s", $column;
    } else {
        return fallback_to_html($h);
    }
};

case ul => sub {
    my ($c, $h) = @_;
    if ($c->in_list) {
        my $ret = "\n";
        for ($h->content_list) {
            if ($_->tag eq 'li') {
                $ret .= sprintf "<ParaStyle:箇条書き2階層目>・%s\n", $c->parse_element($_);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($h->content_list) {
            $c->in_list(1);
            $ret .= '<ParaStyle:箇条書き>・' . $c->parse_element($list) . "\n";
            $c->in_list(0);
        }
        return $ret;
    }
};

case ol => sub {
    my ($c, $h) = @_;
    my $out = '';
    my $style = $h->attr('class') || $c->default_list;
    my $i = 0;
    for my $list ($h->find('li')) {
        $out .= sprintf(
            "<ParaStyle:箇条書き>%s%s\n",
            list_marker($style, ++$i),
            $c->parse_element($list)
        );
    }
    return $out;
};

case pre => sub {
    my ($c, $h) = @_;
    $c->in_code_block(1);

    my $code = $h->find('code');
    my $text = $code ? $code->as_text : '';

    my $list_label = 'リスト';
    my $comment_label = 'リストコメント';

    # 「!!! cmd」で始まるコードブロックはコマンドライン（黒背景）
    if ($text =~ /!!!(\s+)?cmd/) {
        $text =~ s/.+?\n//;
        $list_label .= '白文字';
        $comment_label .= '白地黒文字';
    }

    ## リストスタイル
    $text = replace_list_maker($text);

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
    if ($text =~ m!\(注:! or $c->in_footnote) {
        $text = replace_note_parenthesis($c, $text, '注');
        $text =~ s!◆注/◆!<CharStyle:$comment_label> !g;
        $text =~ s!◆/注◆! <CharStyle:>!g;
    }

    # コード内強調
    $text =~ s!\*\*(.+?)\*\*!<CharStyle:コマンド太字>$1<CharStyle:>!g;

    # コード内イタリック
    $text =~ s!\___(.+?)\___!<CharStyle:イタリック（変形斜体）>$1<CharStyle:>!g;

    chomp $text;

    $c->in_code_block(0);

    my @lines = map {
        if (m/^●(.+?)::(.+)/) {
            sprintf "<ParaStyle:キャプション>%s%s", $1, $2;
        }
        else {
            sprintf "<ParaStyle:%s>%s", $list_label, $_;
        }
    } split /\n/, $text;

    my $lines = join "\n", @lines;
    return <<EOF;
<ParaStyle:$list_label>
$lines
EOF
};

case a => sub {
    my ($c, $h) = @_;
    my $url   = $h->attr('href');
    my $title = $h->as_trimmed_text;
    if ($url and $title) {
        return sprintf "%s<fnStart:><pstyle:注釈>%s<fnEnd:><cstyle:>", $title, $url;
    } else {
        return fallback_to_html($h);
    }
};

case img => sub {
    my ($c, $h) = @_;
    $c->{img_number} += 1;

    my $template = <<EOF;
<ParaStyle:キャプション>●図%d\t%s
<ParaStyle:赤字>%s
EOF

    return sprintf (
        $template,
        $c->{img_number},
        $h->attr('alt') || $h->attr('title'),
        $h->attr('src')
    );
};

case dl => sub {
    my ($c, $h) = @_;
    my $out = '';
    for ($h->descendants) {
        if ($_->tag eq 'dt') {
            $out .= sprintf "<ParaStyle:箇条書き>・%s\n", $c->parse_element($_);
        } elsif ($_->tag eq 'dd') {
            $out .= sprintf "<ParaStyle:箇条書き説明>%s\n", $c->parse_element($_);
        }
    }
    return $out;
};

case table => sub {
    my ($c, $h) = @_;
    my $out = '';

    $out .= "<ParaStyle:表>\n";

    my $summary = $h->attr('summary') || '';
    $summary =~ m!(.+?)::(.+)!;
    $out .= sprintf "<ParaStyle:キャプション>%s\t%s\n", $1, $2;

    for my $table ($h->find('tr')) {
        if (my $header = join "\t", map { $_->as_trimmed_text } $table->find('th')) {
            $out .= sprintf "<ParaStyle:表見出し行>%s\n", $header;
        }

        if (my $data = join "\t", map { $_->as_trimmed_text } $table->find('td')) {
            $out .= sprintf "<ParaStyle:表>%s\n", $data;
        }
    }

    return $out;
};

case hr => sub {
    my ($c, $h) = @_;
    return "<ParaStyle:区切り線>\n"
};

1;
