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
===
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

===
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

===
--- in md2inao
* あ
* あ

  い
--- expected
・あ
・あ
  い

===
--- in md2inao
* Foo

* Bar

* Baz

--- expected
・Foo
・Bar
・Baz

===
--- in md2inao
* あ

* い
--- expected
・あ
・い

===
--- in md2inao
* あ

い
--- expected
・あ
い

===
--- in md2inao
* あ

い

* あ
--- expected
・あ
い
・あ

===
--- in md2inao
あ

 い

  う

    え

     お

　か
--- expected
あ
い
う
◆list/◆
え

 お
◆/list◆
　か

