use utf8;

use Test::Base;
use Text::Md2Inao;

use Encode;

plan tests => 1 * blocks;

run_is in => 'expected';

sub md2inao {
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
    });
    $p->parse($_);
}

__END__
=== case 1
--- in md2inao
* Foo
* Bar
* Baz

  Piyo
--- expected
・Foo
・Bar
・Baz
　Piyo

=== case 2
--- in md2inao
* Foo
* Bar
* Baz

Piyo
--- expected
・Foo
・Bar
・Baz
Piyo

=== case 3
--- in md2inao
* あ
* あ

  い
--- expected
・あ
・あ
　い

=== case 4
--- in md2inao
* Foo

* Bar

* Baz

--- expected
・Foo
・Bar
・Baz

=== case 5
--- in md2inao
* あ

* い
--- expected
・あ
・い

=== case 6
--- in md2inao
* あ

い
--- expected
・あ
い

=== case 7
--- in md2inao
* あ

い

* あ
--- expected
・あ
い
・あ

=== case 8
--- in md2inao
  blah blah

* Hoge
* Foo

  bar

  baz
--- expected
　blah blah
・Hoge
・Foo
　bar
　baz

=== case 8
--- in md2inao
　本文

- 箇条書き1行目
- 箇条書き2行目
- 箇条書き3行目
- 箇条書き4行目

    ●リスト1::リストのキャプション
    code {
      code 
      code
    }

　本文

--- expected
　本文
・箇条書き1行目
・箇条書き2行目
・箇条書き3行目
・箇条書き4行目
◆list/◆
●リスト1	リストのキャプション
code {
  code 
  code
}
◆/list◆
　本文
