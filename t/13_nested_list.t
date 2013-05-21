use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2inao
- Xenoblade
    - Fiorung
    - Shulk
    - Dunban
- DQX
    - Ogre
    - Elf
    - Dwarf
--- expected
・Xenoblade
＊・Fiorung
＊・Shulk
＊・Dunban
・DQX
＊・Ogre
＊・Elf
＊・Dwarf

=== 仕様要確認
--- SKIP in md2inao
- Xenoblade
    - Fiorung
        - Double Blade
        - Healing Energy
        - Spear Blade
    - Shulk
    - Dunban
--- expected
・Xenoblade
＊・Fiorung
＊＊・Double Blade
＊＊・Healing Energy
＊＊・Spear Blade
＊・Shulk
＊・Dunban

