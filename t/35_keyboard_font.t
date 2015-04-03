use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== alphabet
--- in md2inao
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>A<cFont:><cFont:Keyboard-JP>B<cFont:><cFont:Keyboard-JP>C<cFont:><cFont:Keyboard-JP>D<cFont:><cFont:Keyboard-JP>E<cFont:><cFont:Keyboard-JP>F<cFont:><cFont:Keyboard-JP>G<cFont:><cFont:Keyboard-JP>H<cFont:><cFont:Keyboard-JP>I<cFont:><cFont:Keyboard-JP>J<cFont:><cFont:Keyboard-JP>K<cFont:><cFont:Keyboard-JP>L<cFont:><cFont:Keyboard-JP>M<cFont:><cFont:Keyboard-JP>N<cFont:><cFont:Keyboard-JP>O<cFont:><cFont:Keyboard-JP>P<cFont:><cFont:Keyboard-JP>Q<cFont:><cFont:Keyboard-JP>R<cFont:><cFont:Keyboard-JP>S<cFont:><cFont:Keyboard-JP>T<cFont:><cFont:Keyboard-JP>U<cFont:><cFont:Keyboard-JP>V<cFont:><cFont:Keyboard-JP>W<cFont:><cFont:Keyboard-JP>X<cFont:><cFont:Keyboard-JP>Y<cFont:><cFont:Keyboard-JP>Z<cFont:>

=== alphabet
--- in md2inao
a
b
c
d
e
f
g
h
i
j
k
l
m
n
o
p
q
r
s
t
u
v
w
x
y
z
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>a<cFont:><cFont:Keyboard-JP>b<cFont:><cFont:Keyboard-JP>c<cFont:><cFont:Keyboard-JP>d<cFont:><cFont:Keyboard-JP>e<cFont:><cFont:Keyboard-JP>f<cFont:><cFont:Keyboard-JP>g<cFont:><cFont:Keyboard-JP>h<cFont:><cFont:Keyboard-JP>i<cFont:><cFont:Keyboard-JP>j<cFont:><cFont:Keyboard-JP>k<cFont:><cFont:Keyboard-JP>l<cFont:><cFont:Keyboard-JP>m<cFont:><cFont:Keyboard-JP>n<cFont:><cFont:Keyboard-JP>o<cFont:><cFont:Keyboard-JP>p<cFont:><cFont:Keyboard-JP>q<cFont:><cFont:Keyboard-JP>r<cFont:><cFont:Keyboard-JP>s<cFont:><cFont:Keyboard-JP>t<cFont:><cFont:Keyboard-JP>u<cFont:><cFont:Keyboard-JP>v<cFont:><cFont:Keyboard-JP>w<cFont:><cFont:Keyboard-JP>x<cFont:><cFont:Keyboard-JP>y<cFont:><cFont:Keyboard-JP>z<cFont:>

=== number
--- in md2inao
0
1
2
3
4
5
6
7
8
9
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>0<cFont:><cFont:Keyboard-JP>1<cFont:><cFont:Keyboard-JP>2<cFont:><cFont:Keyboard-JP>3<cFont:><cFont:Keyboard-JP>4<cFont:><cFont:Keyboard-JP>5<cFont:><cFont:Keyboard-JP>6<cFont:><cFont:Keyboard-JP>7<cFont:><cFont:Keyboard-JP>8<cFont:><cFont:Keyboard-JP>9<cFont:>

=== hiragana
--- in md2inao
あ
い
う
え
お
か
き
く
け
こ
さ
し
す
せ
そ
た
ち
つ
て
と
な
に
ぬ
ね
の
は
ひ
ふ
へ
ほ
ま
み
む
め
も
や
ゆ
よ
ら
り
る
れ
ろ
わ
を
ん
ぁ
ぃ
ぅ
ぇ
ぉ
ゃ
ゅ
ょ
っ
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>あ<cFont:><cFont:Keyboard-JP>い<cFont:><cFont:Keyboard-JP>う<cFont:><cFont:Keyboard-JP>え<cFont:><cFont:Keyboard-JP>お<cFont:><cFont:Keyboard-JP>か<cFont:><cFont:Keyboard-JP>き<cFont:><cFont:Keyboard-JP>く<cFont:><cFont:Keyboard-JP>け<cFont:><cFont:Keyboard-JP>こ<cFont:><cFont:Keyboard-JP>さ<cFont:><cFont:Keyboard-JP>し<cFont:><cFont:Keyboard-JP>す<cFont:><cFont:Keyboard-JP>せ<cFont:><cFont:Keyboard-JP>そ<cFont:><cFont:Keyboard-JP>た<cFont:><cFont:Keyboard-JP>ち<cFont:><cFont:Keyboard-JP>つ<cFont:><cFont:Keyboard-JP>て<cFont:><cFont:Keyboard-JP>と<cFont:><cFont:Keyboard-JP>な<cFont:><cFont:Keyboard-JP>に<cFont:><cFont:Keyboard-JP>ぬ<cFont:><cFont:Keyboard-JP>ね<cFont:><cFont:Keyboard-JP>の<cFont:><cFont:Keyboard-JP>は<cFont:><cFont:Keyboard-JP>ひ<cFont:><cFont:Keyboard-JP>ふ<cFont:><cFont:Keyboard-JP>へ<cFont:><cFont:Keyboard-JP>ほ<cFont:><cFont:Keyboard-JP>ま<cFont:><cFont:Keyboard-JP>み<cFont:><cFont:Keyboard-JP>む<cFont:><cFont:Keyboard-JP>め<cFont:><cFont:Keyboard-JP>も<cFont:><cFont:Keyboard-JP>や<cFont:><cFont:Keyboard-JP>ゆ<cFont:><cFont:Keyboard-JP>よ<cFont:><cFont:Keyboard-JP>ら<cFont:><cFont:Keyboard-JP>り<cFont:><cFont:Keyboard-JP>る<cFont:><cFont:Keyboard-JP>れ<cFont:><cFont:Keyboard-JP>ろ<cFont:><cFont:Keyboard-JP>わ<cFont:><cFont:Keyboard-JP>を<cFont:><cFont:Keyboard-JP>ん<cFont:><cFont:Keyboard-JP>ぁ<cFont:><cFont:Keyboard-JP>ぃ<cFont:><cFont:Keyboard-JP>ぅ<cFont:><cFont:Keyboard-JP>ぇ<cFont:><cFont:Keyboard-JP>ぉ<cFont:><cFont:Keyboard-JP>ゃ<cFont:><cFont:Keyboard-JP>ゅ<cFont:><cFont:Keyboard-JP>ょ<cFont:><cFont:Keyboard-JP>っ<cFont:>

=== modifier
--- in md2inao
Alt
Backspace
Break
Caps
CapsLock
Cmd
Command
Control
Ctrl
Del
Delete
End
Enter
Esc
Fn
Go
Home
Ins
Insert
NumLock
Option
PageDown
PageUp
Pause
PgDn
PgUp
PrintScreen
Return
ScrollLock
Shift
Space
SysRq
Tab
Windows
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>Alt<cFont:><cFont:Keyboard-JP>Backspace<cFont:><cFont:Keyboard-JP>Break<cFont:><cFont:Keyboard-JP>Caps<cFont:><cFont:Keyboard-JP>CapsLock<cFont:><cFont:Keyboard-JP>Cmd<cFont:><cFont:Keyboard-JP>Command<cFont:><cFont:Keyboard-JP>Control<cFont:><cFont:Keyboard-JP>Ctrl<cFont:><cFont:Keyboard-JP>Del<cFont:><cFont:Keyboard-JP>Delete<cFont:><cFont:Keyboard-JP>End<cFont:><cFont:Keyboard-JP>Enter<cFont:><cFont:Keyboard-JP>Esc<cFont:><cFont:Keyboard-JP>Fn<cFont:><cFont:Keyboard-JP>Go<cFont:><cFont:Keyboard-JP>Home<cFont:><cFont:Keyboard-JP>Ins<cFont:><cFont:Keyboard-JP>Insert<cFont:><cFont:Keyboard-JP>NumLock<cFont:><cFont:Keyboard-JP>Option<cFont:><cFont:Keyboard-JP>PageDown<cFont:><cFont:Keyboard-JP>PageUp<cFont:><cFont:Keyboard-JP>Pause<cFont:><cFont:Keyboard-JP>PgDn<cFont:><cFont:Keyboard-JP>PgUp<cFont:><cFont:Keyboard-JP>PrintScreen<cFont:><cFont:Keyboard-JP>Return<cFont:><cFont:Keyboard-JP>ScrollLock<cFont:><cFont:Keyboard-JP>Shift<cFont:><cFont:Keyboard-JP>Space<cFont:><cFont:Keyboard-JP>SysRq<cFont:><cFont:Keyboard-JP>Tab<cFont:><cFont:Keyboard-JP>Windows<cFont:>

=== modifier
--- in md2inao
alt
caps
capslock
clear
command
control
ctrl
del
delete
end
enter
esc
fn
home
ins
option
pagedown
pageup
return
shift
space
tab
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>alt<cFont:><cFont:Keyboard-JP>caps<cFont:><cFont:Keyboard-JP>capslock<cFont:><cFont:Keyboard-JP>clear<cFont:><cFont:Keyboard-JP>command<cFont:><cFont:Keyboard-JP>control<cFont:><cFont:Keyboard-JP>ctrl<cFont:><cFont:Keyboard-JP>del<cFont:><cFont:Keyboard-JP>delete<cFont:><cFont:Keyboard-JP>end<cFont:><cFont:Keyboard-JP>enter<cFont:><cFont:Keyboard-JP>esc<cFont:><cFont:Keyboard-JP>fn<cFont:><cFont:Keyboard-JP>home<cFont:><cFont:Keyboard-JP>ins<cFont:><cFont:Keyboard-JP>option<cFont:><cFont:Keyboard-JP>pagedown<cFont:><cFont:Keyboard-JP>pageup<cFont:><cFont:Keyboard-JP>return<cFont:><cFont:Keyboard-JP>shift<cFont:><cFont:Keyboard-JP>space<cFont:><cFont:Keyboard-JP>tab<cFont:>

=== function
--- in md2inao
F1
F2
F3
F4
F5
F6
F7
F8
F9
F10
F11
F12
F13
F14
F15
F16
F17
F18
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>F1<cFont:><cFont:Keyboard-JP>F2<cFont:><cFont:Keyboard-JP>F3<cFont:><cFont:Keyboard-JP>F4<cFont:><cFont:Keyboard-JP>F5<cFont:><cFont:Keyboard-JP>F6<cFont:><cFont:Keyboard-JP>F7<cFont:><cFont:Keyboard-JP>F8<cFont:><cFont:Keyboard-JP>F9<cFont:><cFont:Keyboard-JP>F10<cFont:><cFont:Keyboard-JP>F11<cFont:><cFont:Keyboard-JP>F12<cFont:><cFont:Keyboard-JP>F13<cFont:><cFont:Keyboard-JP>F14<cFont:><cFont:Keyboard-JP>F15<cFont:><cFont:Keyboard-JP>F16<cFont:><cFont:Keyboard-JP>F17<cFont:><cFont:Keyboard-JP>F18<cFont:>

=== omake
--- in md2inao
POWER
EJECT
SELECT
START
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>POWER<cFont:><cFont:Keyboard-JP>EJECT<cFont:><cFont:Keyboard-JP>SELECT<cFont:><cFont:Keyboard-JP>START<cFont:>

=== japanese
--- in md2inao
改行
空白
英数
かな
漢字
スペース
ローマ字
カタカナひらがな
半角/全角
変換
無変換
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>改行<cFont:><cFont:Keyboard-JP>空白<cFont:><cFont:Keyboard-JP>英数<cFont:><cFont:Keyboard-JP>かな<cFont:><cFont:Keyboard-JP>漢字<cFont:><cFont:Keyboard-JP>スペース<cFont:><cFont:Keyboard-JP>ローマ字<cFont:><cFont:Keyboard-JP>カタカナひらがな<cFont:><cFont:Keyboard-JP>半角/全角<cFont:><cFont:Keyboard-JP>変換<cFont:><cFont:Keyboard-JP>無変換<cFont:>

=== arrow
--- in md2inao
↑
↓
→
←
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>↑<cFont:><cFont:Keyboard-JP>↓<cFont:><cFont:Keyboard-JP>→<cFont:><cFont:Keyboard-JP>←<cFont:>

=== symbol
--- in md2inao
!
"
#
$
%
&
'
(
)
=
-
^
|
¥
@
{
}
[
]
;
:
+
_
*
/
?
,
.
<
>
「
」
、
。
・
゛
゜
ー
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>!<cFont:><cFont:Keyboard-JP>"<cFont:><cFont:Keyboard-JP>#<cFont:><cFont:Keyboard-JP>$<cFont:><cFont:Keyboard-JP>%<cFont:><cFont:Keyboard-JP>&<cFont:><cFont:Keyboard-JP>'<cFont:><cFont:Keyboard-JP>(<cFont:><cFont:Keyboard-JP>)<cFont:><cFont:Keyboard-JP>=<cFont:><cFont:Keyboard-JP>-<cFont:><cFont:Keyboard-JP>^<cFont:><cFont:Keyboard-JP>|<cFont:><cFont:Keyboard-JP>¥<cFont:><cFont:Keyboard-JP>@<cFont:><cFont:Keyboard-JP>{<cFont:><cFont:Keyboard-JP>}<cFont:><cFont:Keyboard-JP>[<cFont:><cFont:Keyboard-JP>]<cFont:><cFont:Keyboard-JP>;<cFont:><cFont:Keyboard-JP>:<cFont:><cFont:Keyboard-JP>+<cFont:><cFont:Keyboard-JP>_<cFont:><cFont:Keyboard-JP>*<cFont:><cFont:Keyboard-JP>/<cFont:><cFont:Keyboard-JP>?<cFont:><cFont:Keyboard-JP>,<cFont:><cFont:Keyboard-JP>.<cFont:><cFont:Keyboard-JP><<cFont:><cFont:Keyboard-JP><cFont:><cFont:Keyboard-JP>「<cFont:><cFont:Keyboard-JP>」<cFont:><cFont:Keyboard-JP>、<cFont:><cFont:Keyboard-JP>。<cFont:><cFont:Keyboard-JP>・<cFont:><cFont:Keyboard-JP>゛<cFont:><cFont:Keyboard-JP>゜<cFont:><cFont:Keyboard-JP>ー<cFont:>