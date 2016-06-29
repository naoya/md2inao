use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== PHP Markdown Extra style footnote
--- in md2inao
通常の本文[^1]通常の本文

[^1]: 注釈ですよ。_イタリック_
--- expected
通常の本文◆注/◆注釈ですよ。◆i/◆イタリック◆/i◆◆/注◆通常の本文

===
--- in md2inao
通常の本文[^1]通常の本文

[^1]: 注釈ですよ。
--- expected
通常の本文◆注/◆注釈ですよ。◆/注◆通常の本文
