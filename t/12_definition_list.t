use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2inao
<dl>
  <dt>Xenoblade</dt>
  <dd>Fiorung</dd>
  <dd>Shulk</dd>
  <dd>Dunban</dd>

  <dt>DQX</dt>
  <dd>Ogre</dd>
  <dd>Elf</dd>
  <dd>Dwarf</dd>
</dl>
--- expected
・Xenoblade
・・Fiorung
・・Shulk
・・Dunban
・DQX
・・Ogre
・・Elf
・・Dwarf

===
--- in md2inao
<dl>
  <dt>Xenoblade</dt>
  <dd><strong>Fiorung</strong></dd>
</dl>
--- expected
・Xenoblade
・・◆b/◆Fiorung◆/b◆
