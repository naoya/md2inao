use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== alphabet
--- in md2inao
<kbd>A</kbd>
<kbd>B</kbd>
<kbd>C</kbd>
<kbd>D</kbd>
<kbd>E</kbd>
<kbd>F</kbd>
<kbd>G</kbd>
<kbd>H</kbd>
<kbd>I</kbd>
<kbd>J</kbd>
<kbd>K</kbd>
<kbd>L</kbd>
<kbd>M</kbd>
<kbd>N</kbd>
<kbd>O</kbd>
<kbd>P</kbd>
<kbd>Q</kbd>
<kbd>R</kbd>
<kbd>S</kbd>
<kbd>T</kbd>
<kbd>U</kbd>
<kbd>V</kbd>
<kbd>W</kbd>
<kbd>X</kbd>
<kbd>Y</kbd>
<kbd>Z</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>A<cFont:><cFont:Keyboard-JP>B<cFont:><cFont:Keyboard-JP>C<cFont:><cFont:Keyboard-JP>D<cFont:><cFont:Keyboard-JP>E<cFont:><cFont:Keyboard-JP>F<cFont:><cFont:Keyboard-JP>G<cFont:><cFont:Keyboard-JP>H<cFont:><cFont:Keyboard-JP>I<cFont:><cFont:Keyboard-JP>J<cFont:><cFont:Keyboard-JP>K<cFont:><cFont:Keyboard-JP>L<cFont:><cFont:Keyboard-JP>M<cFont:><cFont:Keyboard-JP>N<cFont:><cFont:Keyboard-JP>O<cFont:><cFont:Keyboard-JP>P<cFont:><cFont:Keyboard-JP>Q<cFont:><cFont:Keyboard-JP>R<cFont:><cFont:Keyboard-JP>S<cFont:><cFont:Keyboard-JP>T<cFont:><cFont:Keyboard-JP>U<cFont:><cFont:Keyboard-JP>V<cFont:><cFont:Keyboard-JP>W<cFont:><cFont:Keyboard-JP>X<cFont:><cFont:Keyboard-JP>Y<cFont:><cFont:Keyboard-JP>Z<cFont:>

=== alphabet
--- in md2inao
<kbd>a</kbd>
<kbd>b</kbd>
<kbd>c</kbd>
<kbd>d</kbd>
<kbd>e</kbd>
<kbd>f</kbd>
<kbd>g</kbd>
<kbd>h</kbd>
<kbd>i</kbd>
<kbd>j</kbd>
<kbd>k</kbd>
<kbd>l</kbd>
<kbd>m</kbd>
<kbd>n</kbd>
<kbd>o</kbd>
<kbd>p</kbd>
<kbd>q</kbd>
<kbd>r</kbd>
<kbd>s</kbd>
<kbd>t</kbd>
<kbd>u</kbd>
<kbd>v</kbd>
<kbd>w</kbd>
<kbd>x</kbd>
<kbd>y</kbd>
<kbd>z</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>a<cFont:><cFont:Keyboard-JP>b<cFont:><cFont:Keyboard-JP>c<cFont:><cFont:Keyboard-JP>d<cFont:><cFont:Keyboard-JP>e<cFont:><cFont:Keyboard-JP>f<cFont:><cFont:Keyboard-JP>g<cFont:><cFont:Keyboard-JP>h<cFont:><cFont:Keyboard-JP>i<cFont:><cFont:Keyboard-JP>j<cFont:><cFont:Keyboard-JP>k<cFont:><cFont:Keyboard-JP>l<cFont:><cFont:Keyboard-JP>m<cFont:><cFont:Keyboard-JP>n<cFont:><cFont:Keyboard-JP>o<cFont:><cFont:Keyboard-JP>p<cFont:><cFont:Keyboard-JP>q<cFont:><cFont:Keyboard-JP>r<cFont:><cFont:Keyboard-JP>s<cFont:><cFont:Keyboard-JP>t<cFont:><cFont:Keyboard-JP>u<cFont:><cFont:Keyboard-JP>v<cFont:><cFont:Keyboard-JP>w<cFont:><cFont:Keyboard-JP>x<cFont:><cFont:Keyboard-JP>y<cFont:><cFont:Keyboard-JP>z<cFont:>

=== number
--- in md2inao
<kbd>0</kbd>
<kbd>1</kbd>
<kbd>2</kbd>
<kbd>3</kbd>
<kbd>4</kbd>
<kbd>5</kbd>
<kbd>6</kbd>
<kbd>7</kbd>
<kbd>8</kbd>
<kbd>9</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>0<cFont:><cFont:Keyboard-JP>1<cFont:><cFont:Keyboard-JP>2<cFont:><cFont:Keyboard-JP>3<cFont:><cFont:Keyboard-JP>4<cFont:><cFont:Keyboard-JP>5<cFont:><cFont:Keyboard-JP>6<cFont:><cFont:Keyboard-JP>7<cFont:><cFont:Keyboard-JP>8<cFont:><cFont:Keyboard-JP>9<cFont:>

=== hiragana
--- in md2inao
<kbd>あ</kbd>
<kbd>い</kbd>
<kbd>う</kbd>
<kbd>え</kbd>
<kbd>お</kbd>
<kbd>か</kbd>
<kbd>き</kbd>
<kbd>く</kbd>
<kbd>け</kbd>
<kbd>こ</kbd>
<kbd>さ</kbd>
<kbd>し</kbd>
<kbd>す</kbd>
<kbd>せ</kbd>
<kbd>そ</kbd>
<kbd>た</kbd>
<kbd>ち</kbd>
<kbd>つ</kbd>
<kbd>て</kbd>
<kbd>と</kbd>
<kbd>な</kbd>
<kbd>に</kbd>
<kbd>ぬ</kbd>
<kbd>ね</kbd>
<kbd>の</kbd>
<kbd>は</kbd>
<kbd>ひ</kbd>
<kbd>ふ</kbd>
<kbd>へ</kbd>
<kbd>ほ</kbd>
<kbd>ま</kbd>
<kbd>み</kbd>
<kbd>む</kbd>
<kbd>め</kbd>
<kbd>も</kbd>
<kbd>や</kbd>
<kbd>ゆ</kbd>
<kbd>よ</kbd>
<kbd>ら</kbd>
<kbd>り</kbd>
<kbd>る</kbd>
<kbd>れ</kbd>
<kbd>ろ</kbd>
<kbd>わ</kbd>
<kbd>を</kbd>
<kbd>ん</kbd>
<kbd>ぁ</kbd>
<kbd>ぃ</kbd>
<kbd>ぅ</kbd>
<kbd>ぇ</kbd>
<kbd>ぉ</kbd>
<kbd>ゃ</kbd>
<kbd>ゅ</kbd>
<kbd>ょ</kbd>
<kbd>っ</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>あ<cFont:><cFont:Keyboard-JP>い<cFont:><cFont:Keyboard-JP>う<cFont:><cFont:Keyboard-JP>え<cFont:><cFont:Keyboard-JP>お<cFont:><cFont:Keyboard-JP>か<cFont:><cFont:Keyboard-JP>き<cFont:><cFont:Keyboard-JP>く<cFont:><cFont:Keyboard-JP>け<cFont:><cFont:Keyboard-JP>こ<cFont:><cFont:Keyboard-JP>さ<cFont:><cFont:Keyboard-JP>し<cFont:><cFont:Keyboard-JP>す<cFont:><cFont:Keyboard-JP>せ<cFont:><cFont:Keyboard-JP>そ<cFont:><cFont:Keyboard-JP>た<cFont:><cFont:Keyboard-JP>ち<cFont:><cFont:Keyboard-JP>つ<cFont:><cFont:Keyboard-JP>て<cFont:><cFont:Keyboard-JP>と<cFont:><cFont:Keyboard-JP>な<cFont:><cFont:Keyboard-JP>に<cFont:><cFont:Keyboard-JP>ぬ<cFont:><cFont:Keyboard-JP>ね<cFont:><cFont:Keyboard-JP>の<cFont:><cFont:Keyboard-JP>は<cFont:><cFont:Keyboard-JP>ひ<cFont:><cFont:Keyboard-JP>ふ<cFont:><cFont:Keyboard-JP>へ<cFont:><cFont:Keyboard-JP>ほ<cFont:><cFont:Keyboard-JP>ま<cFont:><cFont:Keyboard-JP>み<cFont:><cFont:Keyboard-JP>む<cFont:><cFont:Keyboard-JP>め<cFont:><cFont:Keyboard-JP>も<cFont:><cFont:Keyboard-JP>や<cFont:><cFont:Keyboard-JP>ゆ<cFont:><cFont:Keyboard-JP>よ<cFont:><cFont:Keyboard-JP>ら<cFont:><cFont:Keyboard-JP>り<cFont:><cFont:Keyboard-JP>る<cFont:><cFont:Keyboard-JP>れ<cFont:><cFont:Keyboard-JP>ろ<cFont:><cFont:Keyboard-JP>わ<cFont:><cFont:Keyboard-JP>を<cFont:><cFont:Keyboard-JP>ん<cFont:><cFont:Keyboard-JP>ぁ<cFont:><cFont:Keyboard-JP>ぃ<cFont:><cFont:Keyboard-JP>ぅ<cFont:><cFont:Keyboard-JP>ぇ<cFont:><cFont:Keyboard-JP>ぉ<cFont:><cFont:Keyboard-JP>ゃ<cFont:><cFont:Keyboard-JP>ゅ<cFont:><cFont:Keyboard-JP>ょ<cFont:><cFont:Keyboard-JP>っ<cFont:>

=== modifier
--- in md2inao
<kbd>Alt</kbd>
<kbd>Backspace</kbd>
<kbd>Break</kbd>
<kbd>Caps</kbd>
<kbd>CapsLock</kbd>
<kbd>Cmd</kbd>
<kbd>Command</kbd>
<kbd>Control</kbd>
<kbd>Ctrl</kbd>
<kbd>Del</kbd>
<kbd>Delete</kbd>
<kbd>End</kbd>
<kbd>Enter</kbd>
<kbd>Esc</kbd>
<kbd>Fn</kbd>
<kbd>Go</kbd>
<kbd>Home</kbd>
<kbd>Ins</kbd>
<kbd>Insert</kbd>
<kbd>NumLock</kbd>
<kbd>Option</kbd>
<kbd>PageDown</kbd>
<kbd>PageUp</kbd>
<kbd>Pause</kbd>
<kbd>PgDn</kbd>
<kbd>PgUp</kbd>
<kbd>PrintScreen</kbd>
<kbd>Return</kbd>
<kbd>ScrollLock</kbd>
<kbd>Shift</kbd>
<kbd>Space</kbd>
<kbd>SysRq</kbd>
<kbd>Tab</kbd>
<kbd>Windows</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>Alt<cFont:><cFont:Keyboard-JP>Backspace<cFont:><cFont:Keyboard-JP>Break<cFont:><cFont:Keyboard-JP>Caps<cFont:><cFont:Keyboard-JP>CapsLock<cFont:><cFont:Keyboard-JP>Cmd<cFont:><cFont:Keyboard-JP>Command<cFont:><cFont:Keyboard-JP>Control<cFont:><cFont:Keyboard-JP>Ctrl<cFont:><cFont:Keyboard-JP>Del<cFont:><cFont:Keyboard-JP>Delete<cFont:><cFont:Keyboard-JP>End<cFont:><cFont:Keyboard-JP>Enter<cFont:><cFont:Keyboard-JP>Esc<cFont:><cFont:Keyboard-JP>Fn<cFont:><cFont:Keyboard-JP>Go<cFont:><cFont:Keyboard-JP>Home<cFont:><cFont:Keyboard-JP>Ins<cFont:><cFont:Keyboard-JP>Insert<cFont:><cFont:Keyboard-JP>NumLock<cFont:><cFont:Keyboard-JP>Option<cFont:><cFont:Keyboard-JP>PageDown<cFont:><cFont:Keyboard-JP>PageUp<cFont:><cFont:Keyboard-JP>Pause<cFont:><cFont:Keyboard-JP>PgDn<cFont:><cFont:Keyboard-JP>PgUp<cFont:><cFont:Keyboard-JP>PrintScreen<cFont:><cFont:Keyboard-JP>Return<cFont:><cFont:Keyboard-JP>ScrollLock<cFont:><cFont:Keyboard-JP>Shift<cFont:><cFont:Keyboard-JP>Space<cFont:><cFont:Keyboard-JP>SysRq<cFont:><cFont:Keyboard-JP>Tab<cFont:><cFont:Keyboard-JP>Windows<cFont:>

=== modifier
--- in md2inao
<kbd>alt</kbd>
<kbd>caps</kbd>
<kbd>capslock</kbd>
<kbd>clear</kbd>
<kbd>command</kbd>
<kbd>control</kbd>
<kbd>ctrl</kbd>
<kbd>del</kbd>
<kbd>delete</kbd>
<kbd>end</kbd>
<kbd>enter</kbd>
<kbd>esc</kbd>
<kbd>fn</kbd>
<kbd>home</kbd>
<kbd>ins</kbd>
<kbd>option</kbd>
<kbd>pagedown</kbd>
<kbd>pageup</kbd>
<kbd>return</kbd>
<kbd>shift</kbd>
<kbd>space</kbd>
<kbd>tab</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>alt<cFont:><cFont:Keyboard-JP>caps<cFont:><cFont:Keyboard-JP>capslock<cFont:><cFont:Keyboard-JP>clear<cFont:><cFont:Keyboard-JP>command<cFont:><cFont:Keyboard-JP>control<cFont:><cFont:Keyboard-JP>ctrl<cFont:><cFont:Keyboard-JP>del<cFont:><cFont:Keyboard-JP>delete<cFont:><cFont:Keyboard-JP>end<cFont:><cFont:Keyboard-JP>enter<cFont:><cFont:Keyboard-JP>esc<cFont:><cFont:Keyboard-JP>fn<cFont:><cFont:Keyboard-JP>home<cFont:><cFont:Keyboard-JP>ins<cFont:><cFont:Keyboard-JP>option<cFont:><cFont:Keyboard-JP>pagedown<cFont:><cFont:Keyboard-JP>pageup<cFont:><cFont:Keyboard-JP>return<cFont:><cFont:Keyboard-JP>shift<cFont:><cFont:Keyboard-JP>space<cFont:><cFont:Keyboard-JP>tab<cFont:>

=== function
--- in md2inao
<kbd>F1</kbd>
<kbd>F2</kbd>
<kbd>F3</kbd>
<kbd>F4</kbd>
<kbd>F5</kbd>
<kbd>F6</kbd>
<kbd>F7</kbd>
<kbd>F8</kbd>
<kbd>F9</kbd>
<kbd>F10</kbd>
<kbd>F11</kbd>
<kbd>F12</kbd>
<kbd>F13</kbd>
<kbd>F14</kbd>
<kbd>F15</kbd>
<kbd>F16</kbd>
<kbd>F17</kbd>
<kbd>F18</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>F1<cFont:><cFont:Keyboard-JP>F2<cFont:><cFont:Keyboard-JP>F3<cFont:><cFont:Keyboard-JP>F4<cFont:><cFont:Keyboard-JP>F5<cFont:><cFont:Keyboard-JP>F6<cFont:><cFont:Keyboard-JP>F7<cFont:><cFont:Keyboard-JP>F8<cFont:><cFont:Keyboard-JP>F9<cFont:><cFont:Keyboard-JP>F10<cFont:><cFont:Keyboard-JP>F11<cFont:><cFont:Keyboard-JP>F12<cFont:><cFont:Keyboard-JP>F13<cFont:><cFont:Keyboard-JP>F14<cFont:><cFont:Keyboard-JP>F15<cFont:><cFont:Keyboard-JP>F16<cFont:><cFont:Keyboard-JP>F17<cFont:><cFont:Keyboard-JP>F18<cFont:>

=== omake
--- in md2inao
<kbd>POWER</kbd>
<kbd>EJECT</kbd>
<kbd>SELECT</kbd>
<kbd>START</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>POWER<cFont:><cFont:Keyboard-JP>EJECT<cFont:><cFont:Keyboard-JP>SELECT<cFont:><cFont:Keyboard-JP>START<cFont:>

=== japanese
--- in md2inao
<kbd>改行</kbd>
<kbd>空白</kbd>
<kbd>英数</kbd>
<kbd>かな</kbd>
<kbd>漢字</kbd>
<kbd>スペース</kbd>
<kbd>ローマ字</kbd>
<kbd>カタカナひらがな</kbd>
<kbd>半角/全角</kbd>
<kbd>変換</kbd>
<kbd>無変換</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>改行<cFont:><cFont:Keyboard-JP>空白<cFont:><cFont:Keyboard-JP>英数<cFont:><cFont:Keyboard-JP>かな<cFont:><cFont:Keyboard-JP>漢字<cFont:><cFont:Keyboard-JP>スペース<cFont:><cFont:Keyboard-JP>ローマ字<cFont:><cFont:Keyboard-JP>カタカナひらがな<cFont:><cFont:Keyboard-JP>半角/全角<cFont:><cFont:Keyboard-JP>変換<cFont:><cFont:Keyboard-JP>無変換<cFont:>

=== arrow
--- in md2inao
<kbd>↑</kbd>
<kbd>↓</kbd>
<kbd>→</kbd>
<kbd>←</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>↑<cFont:><cFont:Keyboard-JP>↓<cFont:><cFont:Keyboard-JP>→<cFont:><cFont:Keyboard-JP>←<cFont:>

=== symbol
--- in md2inao
<kbd>!</kbd>
<kbd>"</kbd>
<kbd>#</kbd>
<kbd>$</kbd>
<kbd>%</kbd>
<kbd>&</kbd>
<kbd>'</kbd>
<kbd>(</kbd>
<kbd>)</kbd>
<kbd>=</kbd>
<kbd>-</kbd>
<kbd>^</kbd>
<kbd>|</kbd>
<kbd>¥</kbd>
<kbd>@</kbd>
<kbd>{</kbd>
<kbd>}</kbd>
<kbd>[</kbd>
<kbd>]</kbd>
<kbd>;</kbd>
<kbd>:</kbd>
<kbd>+</kbd>
<kbd>_</kbd>
<kbd>*</kbd>
<kbd>/</kbd>
<kbd>?</kbd>
<kbd>,</kbd>
<kbd>.</kbd>
<kbd><</kbd>
<kbd>></kbd>
<kbd>「</kbd>
<kbd>」</kbd>
<kbd>、</kbd>
<kbd>。</kbd>
<kbd>・</kbd>
<kbd>゛</kbd>
<kbd>゜</kbd>
<kbd>ー</kbd>
--- expected
<ParaStyle:本文><cFont:Keyboard-JP>!<cFont:><cFont:Keyboard-JP>"<cFont:><cFont:Keyboard-JP>#<cFont:><cFont:Keyboard-JP>$<cFont:><cFont:Keyboard-JP>%<cFont:><cFont:Keyboard-JP>&<cFont:><cFont:Keyboard-JP>'<cFont:><cFont:Keyboard-JP>(<cFont:><cFont:Keyboard-JP>)<cFont:><cFont:Keyboard-JP>=<cFont:><cFont:Keyboard-JP>-<cFont:><cFont:Keyboard-JP>^<cFont:><cFont:Keyboard-JP>|<cFont:><cFont:Keyboard-JP>¥<cFont:><cFont:Keyboard-JP>@<cFont:><cFont:Keyboard-JP>{<cFont:><cFont:Keyboard-JP>}<cFont:><cFont:Keyboard-JP>[<cFont:><cFont:Keyboard-JP>]<cFont:><cFont:Keyboard-JP>;<cFont:><cFont:Keyboard-JP>:<cFont:><cFont:Keyboard-JP>+<cFont:><cFont:Keyboard-JP>_<cFont:><cFont:Keyboard-JP>*<cFont:><cFont:Keyboard-JP>/<cFont:><cFont:Keyboard-JP>?<cFont:><cFont:Keyboard-JP>,<cFont:><cFont:Keyboard-JP>.<cFont:><cFont:Keyboard-JP><<cFont:><cFont:Keyboard-JP><cFont:><cFont:Keyboard-JP>「<cFont:><cFont:Keyboard-JP>」<cFont:><cFont:Keyboard-JP>、<cFont:><cFont:Keyboard-JP>。<cFont:><cFont:Keyboard-JP>・<cFont:><cFont:Keyboard-JP>゛<cFont:><cFont:Keyboard-JP>゜<cFont:><cFont:Keyboard-JP>ー<cFont:>