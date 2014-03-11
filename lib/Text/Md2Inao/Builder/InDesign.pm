package Text::Md2Inao::Builder::InDesign;
use utf8;
use strict;
use warnings;

use parent qw/Text::Md2Inao::Builder/;
use Text::Md2Inao::Builder::DSL;

use Text::Md2Inao::Logger;
use Text::Md2Inao::Util;
use File::ShareDir qw(dist_dir);
use Path::Tiny;
use List::Util qw/max/;

tie my %meta2label, "Tie::IxHash",
    author               => '著者',
    'author(romaji)'     => '著者（ローマ字）',
    supervisor           => '監修',
    'supervisor(romaji)' => '監修（ローマ字）',
    affiliation          => '所属',
    url                  => 'URL',
    mail                 => 'mail',
    github               => 'Github',
    twitter              => 'Twitter',
;

sub _new {
    my $class = shift;
    my $self = $class->SUPER::_new(@_);

    # check the repo's config/ first, and then try to get dist_dir()
    for my $dir('config', eval { dist_dir('Text-Md2Inao') }) {
        if (-d $dir) {
            $self->load_filter_config(path($dir, 'id_filter.json'));
            last;
        }
    }
    return $self;
}

sub prepend_metadata {
    my ($self, $c, $text) = @_;
    if ($c->metadata) {
        my @lines;
        if (my $chapter = $c->metadata->{chapter}) {
            push @lines, sprintf "<ParaStyle:章番号・連載回数>章番号：第%d章", $chapter;
        }

        if (my $serial = $c->metadata->{serial}) {
            push @lines, sprintf "<ParaStyle:章番号・連載回数>連載回数：第%d回", $serial;
        }

       if (my $title = $c->metadata->{title}) {
            push @lines, sprintf "<ParaStyle:タイトル>タイトル：%s", $title;
        }

        if (my $subtitle = $c->metadata->{subtitle}) {
            push @lines, sprintf "<ParaStyle:キャッチ>キャッチ：%s", $subtitle;
        }

        for (keys %meta2label) {
            if (my $value = $c->metadata->{$_}) {
                push @lines, sprintf "<ParaStyle:本文>%s：%s", $meta2label{$_}, $value;
            }
        }
        $text = join "\n", @lines, $text;
    }
    return $text;
}

sub after_filter {
    my ($self, $c, $out) = @_;
    $out = $self->prepend_metadata($c, $out);
    $out = $self->SUPER::after_filter($c, $out);
    chomp $out;
    return <<EOF;
<SJIS-MAC>
$out
EOF
}

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

sub escape_html {
    my $html = shift;
    $html =~ s/([<>])/<005C>$1/g;
    return $html;
}

sub fallback_to_escaped_html {
    return escape_html(fallback_to_html(shift));
}

sub blank_line {
    my $c = shift;
    if ($c->blank_style and $c->blank_style eq 'full') {
        return '<ParaStyle:本文>';
    } else {
        $c->in_column ? return '<ParaStyle:コラム半行アキ>' : return '<ParaStyle:半行アキ>'
    }
}

case default => sub {
    my ($c, $h) = @_;
    $h->as_HTML('', '', {});
};

case text => sub {
    my ($c, $text) = @_;
    $text = escape_html($text);

    if ($text =~ m!\(注:! or $c->in_footnote) {
        $text = replace_note_parenthesis($c, $text, '注');
        $text =~ s!◆注/◆!<cstyle:上付き><fnStart:><pstyle:注釈>!g;
        $text =~ s!◆/注◆!<fnEnd:><cstyle:>!g;
    }

    # 各行の余計な先頭空白を取り除く (全角は字下げ指定なので残す)
    $text =~ s/^[ ]+//mg;

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
    return sprintf "<ParaStyle:大見出し>%s\n", $c->parse_element($h);
};

case "h2" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:中見出し>%s\n", $c->parse_element($h);
};

case "h3" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:小見出し>%s\n", $c->parse_element($h);
};

case "h4" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:コラムタイトル>%s\n", $c->parse_element($h);
};

case "h5" => sub {
    my ($c, $h) = @_;
    return sprintf "<ParaStyle:コラム小見出し>%s\n", $c->parse_element($h);
};

case strong => sub {
    my ($c, $h) = @_;
    return sprintf "<CharStyle:太字>%s<CharStyle:>", $c->parse_element($h);
};

case em => sub {
    my ($c, $h) = @_;
    my $ret;
    $ret .= $c->use_special_italic ? '<CharStyle:イタリック（変形斜体）>' : '<CharStyle:イタリック（変形斜体）>';
    $ret .= $c->parse_element($h);
    $ret .= '<CharStyle:>';
    return $ret;
};

case code => sub {
    my ($c, $h) = @_;
    return sprintf "<CharStyle:コマンド>%s<CharStyle:>", $c->parse_element($h);
};

case p => sub {
    my ($c, $h) = @_;
    my $text = $c->parse_element($h);
    if ($text !~ /^[\s　]+$/) {
        if ($text =~ /^<ParaStyle:キャプション>/) { ## Dirty Hack...
            return $text;
        }

        my $label;
        if ($c->in_column) {
            $label = 'コラム本文';
        } elsif ($c->in_quote_block) {
            $label = '引用';
        } else {
            $label = '本文';
        }
        return sprintf "<ParaStyle:%s>%s\n", $label, $text;
    }
};

case kbd => sub {
    my ($c, $h) = @_;
    sprintf "<cFont:KeyMother>%s<cFont:>" , $c->parse_element($h);
};

case span => sub {
    my ($c, $h) = @_;
    if ($h->attr('class') eq 'red') {
        return sprintf "<CharStyle:赤字>%s<CharStyle:>", $c->parse_element($h);
    }
    elsif ($h->attr('class') eq 'ruby') {
        my $ruby = $h->as_trimmed_text;
        $ruby =~ s!(.+)\((.+)\)!<cr:1><crstr:$2><cmojir:0>$1<cr:><crstr:><cmojir:>!;
        return $ruby;
    }

    ## ここでは inao に変換して、後で自由置換で変換
    elsif ($h->attr('class') eq 'symbol') {
        return sprintf "◆%s◆", $c->parse_element($h);
    }

    else {
        return fallback_to_escaped_html($h);
    }
};

case blockquote => sub {
    my ($c, $h) = @_;
    $c->in_quote_block(1);
    my $blockquote = $c->parse_element($_);
    $c->in_quote_block(0);
    return $blockquote;
};

case div => sub {
    my ($c,  $h) = @_;

    if ($h->attr('class') eq 'column') {
        $c->in_column(1);

        # HTMLとして取得してcolumn自信のdivタグを削除
        my $md = $h->as_HTML('');
        $md =~ s/^<div.+?>//;
        $md =~ s/<\/div>$//;

        my $column = $c->parse_markdown($md);
        $c->in_column(0);
        return $column;
    } else {
        return fallback_to_escaped_html($h);
    }
};

case ul => sub {
    my ($c, $h) = @_;
    my $label = $c->in_column ? 'コラム箇条書き' : '箇条書き';

    if ($c->in_list) {
        my $ret = "\n";
        for ($h->content_list) {
            if ($_->tag eq 'li') {
                $ret .= sprintf "<ParaStyle:%s2階層目>・%s\n", $label, $c->parse_element($_);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($h->content_list) {
            $c->in_list(1);
            $ret .= sprintf("<ParaStyle:%s>・%s\n", $label, $c->parse_element($list));
            $c->in_list(0);
        }
        chomp $ret;
        my $blank = blank_line($c);
        return <<EOF;
$blank
$ret
EOF
    }
};

case ol => sub {
    my ($c, $h) = @_;
    my $out = '';
    my $label = $c->in_column ? 'コラム箇条書き' : '箇条書き';
    my $style = $h->attr('class') || $c->default_list;
    my $i = 0;
    for my $list ($h->find('li')) {
        $out .= sprintf(
            "<ParaStyle:%s>%s%s\n",
            $label,
            list_marker($style, ++$i),
            $c->parse_element($list)
        );
    }
    chomp $out;
    my $blank = blank_line($c);
    return <<EOF;
$blank
$out
EOF
};

case pre => sub {
    my ($c, $h) = @_;
    $c->in_code_block(1);

    my $code = $h->find('code');
    my $text = $code ? $code->as_text : '';
    $text = escape_html($text);

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

    my $has_caption;
    my @lines = map {
        if (m/^●(.+?)::(.+)/) {
            $has_caption = 1;
            sprintf "<ParaStyle:キャプション>%s\t%s", $1, $2;
        }
        else {
            sprintf "<ParaStyle:%s>%s", $list_label, $_;
        }
    } split /\n/, $text;

    my $lines = join "\n", @lines;
    if ($has_caption) {
        return $lines . "\n";
    } else {
        my $blank = blank_line($c);
        return <<EOF;
$blank
$lines
EOF
    }
};

case a => sub {
    my ($c, $h) = @_;
    my $url   = $h->attr('href');
    my $title = $c->parse_element($h);
    if ($url and $title) {
        return sprintf "%s<cstyle:上付き><fnStart:><pstyle:注釈>%s<fnEnd:><cstyle:>", $title, $url;
    } else {
        return fallback_to_escaped_html($h);
    }
};

case img => sub {
    my ($c, $h) = @_;
    $c->{img_number} += 1;

    my $template = <<EOF;
<ParaStyle:キャプション>●図%d\t%s
<ParaStyle:赤字段落>%s
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
    my $label = $c->in_column ? 'コラム箇条書き' : '箇条書き';
    for ($h->descendants) {
        if ($_->tag eq 'dt') {
            $out .= sprintf "<ParaStyle:%s>・%s\n", $label, $c->parse_element($_);
        } elsif ($_->tag eq 'dd') {
            $out .= sprintf "<ParaStyle:%s説明>%s\n", $label, $c->parse_element($_);
        }
    }
    chomp $out;
    my $blank = blank_line($c);
    return <<EOF;
$blank
$out
EOF
};

case table => sub {
    my ($c, $h) = @_;
    my $out = '';

    my $summary = $h->attr('summary') || '';
    $summary =~ m!(.+?)::(.+)!;
    $out .= sprintf "<ParaStyle:キャプション>%s\t%s\n", $1, $2;

    for my $table ($h->find('tr')) {
        if (my $header = join "\t", map { $c->parse_element($_) } $table->find('th')) {
            $out .= sprintf "<ParaStyle:表見出し行>%s\n", $header;
        }

        if (my $data = join "\t", map { $c->parse_element($_) } $table->find('td')) {
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
