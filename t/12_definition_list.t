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
