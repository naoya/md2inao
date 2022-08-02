use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

sub _md2id {
    my $out = md2id($_);
    $out =~ s/<SJIS-MAC>\n//;
    return $out;
}

__END__
=== alphabet
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>A<CharStyle:><CharStyle:キーボード>B<CharStyle:><CharStyle:キーボード>C<CharStyle:><CharStyle:キーボード>D<CharStyle:><CharStyle:キーボード>E<CharStyle:><CharStyle:キーボード>F<CharStyle:><CharStyle:キーボード>G<CharStyle:><CharStyle:キーボード>H<CharStyle:><CharStyle:キーボード>I<CharStyle:><CharStyle:キーボード>J<CharStyle:><CharStyle:キーボード>K<CharStyle:><CharStyle:キーボード>L<CharStyle:><CharStyle:キーボード>M<CharStyle:><CharStyle:キーボード>N<CharStyle:><CharStyle:キーボード>O<CharStyle:><CharStyle:キーボード>P<CharStyle:><CharStyle:キーボード>Q<CharStyle:><CharStyle:キーボード>R<CharStyle:><CharStyle:キーボード>S<CharStyle:><CharStyle:キーボード>T<CharStyle:><CharStyle:キーボード>U<CharStyle:><CharStyle:キーボード>V<CharStyle:><CharStyle:キーボード>W<CharStyle:><CharStyle:キーボード>X<CharStyle:><CharStyle:キーボード>Y<CharStyle:><CharStyle:キーボード>Z<CharStyle:>

=== alphabet
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>a<CharStyle:><CharStyle:キーボード>b<CharStyle:><CharStyle:キーボード>c<CharStyle:><CharStyle:キーボード>d<CharStyle:><CharStyle:キーボード>e<CharStyle:><CharStyle:キーボード>f<CharStyle:><CharStyle:キーボード>g<CharStyle:><CharStyle:キーボード>h<CharStyle:><CharStyle:キーボード>i<CharStyle:><CharStyle:キーボード>j<CharStyle:><CharStyle:キーボード>k<CharStyle:><CharStyle:キーボード>l<CharStyle:><CharStyle:キーボード>m<CharStyle:><CharStyle:キーボード>n<CharStyle:><CharStyle:キーボード>o<CharStyle:><CharStyle:キーボード>p<CharStyle:><CharStyle:キーボード>q<CharStyle:><CharStyle:キーボード>r<CharStyle:><CharStyle:キーボード>s<CharStyle:><CharStyle:キーボード>t<CharStyle:><CharStyle:キーボード>u<CharStyle:><CharStyle:キーボード>v<CharStyle:><CharStyle:キーボード>w<CharStyle:><CharStyle:キーボード>x<CharStyle:><CharStyle:キーボード>y<CharStyle:><CharStyle:キーボード>z<CharStyle:>

=== number
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>0<CharStyle:><CharStyle:キーボード>1<CharStyle:><CharStyle:キーボード>2<CharStyle:><CharStyle:キーボード>3<CharStyle:><CharStyle:キーボード>4<CharStyle:><CharStyle:キーボード>5<CharStyle:><CharStyle:キーボード>6<CharStyle:><CharStyle:キーボード>7<CharStyle:><CharStyle:キーボード>8<CharStyle:><CharStyle:キーボード>9<CharStyle:>

=== hiragana
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>あ<CharStyle:><CharStyle:キーボード>い<CharStyle:><CharStyle:キーボード>う<CharStyle:><CharStyle:キーボード>え<CharStyle:><CharStyle:キーボード>お<CharStyle:><CharStyle:キーボード>か<CharStyle:><CharStyle:キーボード>き<CharStyle:><CharStyle:キーボード>く<CharStyle:><CharStyle:キーボード>け<CharStyle:><CharStyle:キーボード>こ<CharStyle:><CharStyle:キーボード>さ<CharStyle:><CharStyle:キーボード>し<CharStyle:><CharStyle:キーボード>す<CharStyle:><CharStyle:キーボード>せ<CharStyle:><CharStyle:キーボード>そ<CharStyle:><CharStyle:キーボード>た<CharStyle:><CharStyle:キーボード>ち<CharStyle:><CharStyle:キーボード>つ<CharStyle:><CharStyle:キーボード>て<CharStyle:><CharStyle:キーボード>と<CharStyle:><CharStyle:キーボード>な<CharStyle:><CharStyle:キーボード>に<CharStyle:><CharStyle:キーボード>ぬ<CharStyle:><CharStyle:キーボード>ね<CharStyle:><CharStyle:キーボード>の<CharStyle:><CharStyle:キーボード>は<CharStyle:><CharStyle:キーボード>ひ<CharStyle:><CharStyle:キーボード>ふ<CharStyle:><CharStyle:キーボード>へ<CharStyle:><CharStyle:キーボード>ほ<CharStyle:><CharStyle:キーボード>ま<CharStyle:><CharStyle:キーボード>み<CharStyle:><CharStyle:キーボード>む<CharStyle:><CharStyle:キーボード>め<CharStyle:><CharStyle:キーボード>も<CharStyle:><CharStyle:キーボード>や<CharStyle:><CharStyle:キーボード>ゆ<CharStyle:><CharStyle:キーボード>よ<CharStyle:><CharStyle:キーボード>ら<CharStyle:><CharStyle:キーボード>り<CharStyle:><CharStyle:キーボード>る<CharStyle:><CharStyle:キーボード>れ<CharStyle:><CharStyle:キーボード>ろ<CharStyle:><CharStyle:キーボード>わ<CharStyle:><CharStyle:キーボード>を<CharStyle:><CharStyle:キーボード>ん<CharStyle:><CharStyle:キーボード>ぁ<CharStyle:><CharStyle:キーボード>ぃ<CharStyle:><CharStyle:キーボード>ぅ<CharStyle:><CharStyle:キーボード>ぇ<CharStyle:><CharStyle:キーボード>ぉ<CharStyle:><CharStyle:キーボード>ゃ<CharStyle:><CharStyle:キーボード>ゅ<CharStyle:><CharStyle:キーボード>ょ<CharStyle:><CharStyle:キーボード>っ<CharStyle:>

=== modifier
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>Alt<CharStyle:><CharStyle:キーボード>Backspace<CharStyle:><CharStyle:キーボード>Break<CharStyle:><CharStyle:キーボード>Caps<CharStyle:><CharStyle:キーボード>CapsLock<CharStyle:><CharStyle:キーボード>Cmd<CharStyle:><CharStyle:キーボード>Command<CharStyle:><CharStyle:キーボード>Control<CharStyle:><CharStyle:キーボード>Ctrl<CharStyle:><CharStyle:キーボード>Del<CharStyle:><CharStyle:キーボード>Delete<CharStyle:><CharStyle:キーボード>End<CharStyle:><CharStyle:キーボード>Enter<CharStyle:><CharStyle:キーボード>Esc<CharStyle:><CharStyle:キーボード>Fn<CharStyle:><CharStyle:キーボード>Go<CharStyle:><CharStyle:キーボード>Home<CharStyle:><CharStyle:キーボード>Ins<CharStyle:><CharStyle:キーボード>Insert<CharStyle:><CharStyle:キーボード>NumLock<CharStyle:><CharStyle:キーボード>Option<CharStyle:><CharStyle:キーボード>PageDown<CharStyle:><CharStyle:キーボード>PageUp<CharStyle:><CharStyle:キーボード>Pause<CharStyle:><CharStyle:キーボード>PgDn<CharStyle:><CharStyle:キーボード>PgUp<CharStyle:><CharStyle:キーボード>PrintScreen<CharStyle:><CharStyle:キーボード>Return<CharStyle:><CharStyle:キーボード>ScrollLock<CharStyle:><CharStyle:キーボード>Shift<CharStyle:><CharStyle:キーボード>Space<CharStyle:><CharStyle:キーボード>SysRq<CharStyle:><CharStyle:キーボード>Tab<CharStyle:><CharStyle:キーボード>Windows<CharStyle:>

=== modifier
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>alt<CharStyle:><CharStyle:キーボード>caps<CharStyle:><CharStyle:キーボード>capslock<CharStyle:><CharStyle:キーボード>clear<CharStyle:><CharStyle:キーボード>command<CharStyle:><CharStyle:キーボード>control<CharStyle:><CharStyle:キーボード>ctrl<CharStyle:><CharStyle:キーボード>del<CharStyle:><CharStyle:キーボード>delete<CharStyle:><CharStyle:キーボード>end<CharStyle:><CharStyle:キーボード>enter<CharStyle:><CharStyle:キーボード>esc<CharStyle:><CharStyle:キーボード>fn<CharStyle:><CharStyle:キーボード>home<CharStyle:><CharStyle:キーボード>ins<CharStyle:><CharStyle:キーボード>option<CharStyle:><CharStyle:キーボード>pagedown<CharStyle:><CharStyle:キーボード>pageup<CharStyle:><CharStyle:キーボード>return<CharStyle:><CharStyle:キーボード>shift<CharStyle:><CharStyle:キーボード>space<CharStyle:><CharStyle:キーボード>tab<CharStyle:>

=== function
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>F1<CharStyle:><CharStyle:キーボード>F2<CharStyle:><CharStyle:キーボード>F3<CharStyle:><CharStyle:キーボード>F4<CharStyle:><CharStyle:キーボード>F5<CharStyle:><CharStyle:キーボード>F6<CharStyle:><CharStyle:キーボード>F7<CharStyle:><CharStyle:キーボード>F8<CharStyle:><CharStyle:キーボード>F9<CharStyle:><CharStyle:キーボード>F10<CharStyle:><CharStyle:キーボード>F11<CharStyle:><CharStyle:キーボード>F12<CharStyle:><CharStyle:キーボード>F13<CharStyle:><CharStyle:キーボード>F14<CharStyle:><CharStyle:キーボード>F15<CharStyle:><CharStyle:キーボード>F16<CharStyle:><CharStyle:キーボード>F17<CharStyle:><CharStyle:キーボード>F18<CharStyle:>

=== omake
--- in _md2id
<kbd>POWER</kbd>
<kbd>EJECT</kbd>
<kbd>SELECT</kbd>
<kbd>START</kbd>
--- expected
<ParaStyle:本文><CharStyle:キーボード>POWER<CharStyle:><CharStyle:キーボード>EJECT<CharStyle:><CharStyle:キーボード>SELECT<CharStyle:><CharStyle:キーボード>START<CharStyle:>

=== japanese
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>改行<CharStyle:><CharStyle:キーボード>空白<CharStyle:><CharStyle:キーボード>英数<CharStyle:><CharStyle:キーボード>かな<CharStyle:><CharStyle:キーボード>漢字<CharStyle:><CharStyle:キーボード>スペース<CharStyle:><CharStyle:キーボード>ローマ字<CharStyle:><CharStyle:キーボード>カタカナひらがな<CharStyle:><CharStyle:キーボード>半角/全角<CharStyle:><CharStyle:キーボード>変換<CharStyle:><CharStyle:キーボード>無変換<CharStyle:>

=== arrow
--- in _md2id
<kbd>↑</kbd>
<kbd>↓</kbd>
<kbd>→</kbd>
<kbd>←</kbd>
--- expected
<ParaStyle:本文><CharStyle:キーボード>↑<CharStyle:><CharStyle:キーボード>↓<CharStyle:><CharStyle:キーボード>→<CharStyle:><CharStyle:キーボード>←<CharStyle:>

=== symbol
--- in _md2id
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
<ParaStyle:本文><CharStyle:キーボード>!<CharStyle:><CharStyle:キーボード>"<CharStyle:><CharStyle:キーボード>#<CharStyle:><CharStyle:キーボード>$<CharStyle:><CharStyle:キーボード>%<CharStyle:><CharStyle:キーボード>&<CharStyle:><CharStyle:キーボード>'<CharStyle:><CharStyle:キーボード>(<CharStyle:><CharStyle:キーボード>)<CharStyle:><CharStyle:キーボード>=<CharStyle:><CharStyle:キーボード>-<CharStyle:><CharStyle:キーボード>^<CharStyle:><CharStyle:キーボード>|<CharStyle:><CharStyle:キーボード>¥<CharStyle:><CharStyle:キーボード>@<CharStyle:><CharStyle:キーボード>{<CharStyle:><CharStyle:キーボード>}<CharStyle:><CharStyle:キーボード>[<CharStyle:><CharStyle:キーボード>]<CharStyle:><CharStyle:キーボード>;<CharStyle:><CharStyle:キーボード>:<CharStyle:><CharStyle:キーボード>+<CharStyle:><CharStyle:キーボード>_<CharStyle:><CharStyle:キーボード>*<CharStyle:><CharStyle:キーボード>/<CharStyle:><CharStyle:キーボード>?<CharStyle:><CharStyle:キーボード>,<CharStyle:><CharStyle:キーボード>.<CharStyle:><CharStyle:キーボード><005C><<CharStyle:><CharStyle:キーボード><005C>><CharStyle:><CharStyle:キーボード>「<CharStyle:><CharStyle:キーボード>」<CharStyle:><CharStyle:キーボード>、<CharStyle:><CharStyle:キーボード>。<CharStyle:><CharStyle:キーボード>・<CharStyle:><CharStyle:キーボード>゛<CharStyle:><CharStyle:キーボード>゜<CharStyle:><CharStyle:キーボード>ー<CharStyle:>
