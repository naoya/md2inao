use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
===
--- in md2inao
本文(注:普通の脚注)本文の続き。
--- expected
本文◆注/◆普通の脚注◆/注◆本文の続き。

===
--- in md2inao
本文(注:脚注の中に()がある)本文の続き。
--- expected
本文◆注/◆脚注の中に()がある◆/注◆本文の続き。

===
--- in md2inao
本文(注:脚注の中に(かっこ)がある)本文の続き。
--- expected
本文◆注/◆脚注の中に(かっこ)がある◆/注◆本文の続き。

===
--- in md2inao
本文(注:脚注の中に(かっこ(さらにかっこ))がある)本文の続き。
--- expected
本文◆注/◆脚注の中に(かっこ(さらにかっこ))がある◆/注◆本文の続き。

===
--- in md2inao
本文(注:脚注1)本文の続き(注:脚注2)終わり。
--- expected
本文◆注/◆脚注1◆/注◆本文の続き◆注/◆脚注2◆/注◆終わり。

===
--- in md2inao
本文(注:脚注の中に_イタリック_)本文の続き。
--- expected
本文◆注/◆脚注の中に◆i/◆イタリック◆/i◆◆/注◆本文の続き。

===
--- in md2inao
本文(注:脚注の中に_イタリック_が_二つ_)本文の続き。
--- expected
本文◆注/◆脚注の中に◆i/◆イタリック◆/i◆が◆i/◆二つ◆/i◆◆/注◆本文の続き。

===
--- in md2inao
本文(普通の括弧の中に(注:脚注)がある)本文の続き。
--- expected
本文(普通の括弧の中に◆注/◆脚注◆/注◆がある)本文の続き。

===
--- in md2inao
    ●リスト1::リストの注
    (注:リストの注)
    codecodecodecodecodecodecodecodecode
    codecodecodecodecodecodecode
    codecodecode
--- expected
◆list/◆
●リスト1	リストの注
◆comment/◆リストの注◆/comment◆
codecodecodecodecodecodecodecodecode
codecodecodecodecodecodecode
codecodecode
◆/list◆

===
--- in md2inao
    (注:リストの中も()があるとおかしくなる)
--- expected
◆list/◆
◆comment/◆リストの中も()があるとおかしくなる◆/comment◆
◆/list◆
