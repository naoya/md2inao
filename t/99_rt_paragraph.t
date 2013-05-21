use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2inao
hogehoge
fugafuga
--- expected
hogehogefugafuga

===
--- in md2inao
　hogehoge
fugafuga
--- expected
　hogehogefugafuga

===
--- in md2inao
　hogehoge
　fugafuga
--- expected
　hogehoge
　fugafuga

===
--- in md2inao
hogehoge
　fugafuga
--- expected
hogehoge
　fugafuga

===
--- in md2inao
　hogehoge

　fugafuga
--- expected
　hogehoge
　fugafuga
