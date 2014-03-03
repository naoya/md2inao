use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== unclosed anchor tag
--- SKIP in md2inao
<a>
--- expected
<a>

=== unclosed anchor tag with attribute
--- SKIP in md2inao
<a title="foobar">
--- expected
<a title="foobar">

=== closed anchor tag
--- in md2inao
<a>ほげほげ</a>
--- expected
<a>ほげほげ</a>

=== anchor tags to inao
--- in md2inao
<a href="http://www.example.com">example.com</a>
--- expected
example.com◆注/◆http://www.example.com◆/注◆

=== Markdown reference notation to inao
--- in md2inao
[RubyMotion](http://www.rubymotion.org/)
--- expected
RubyMotion◆注/◆http://www.rubymotion.org/◆/注◆

=== unclosed bold tag
--- SKIP in md2inao
<b>
--- expected
<b>

=== closed bold tag
--- in md2inao
<b>ほげほげ</b>
--- expected
<b>ほげほげ</b>

=== escaped brakets
--- in md2inao
&lt;strong&gt;
--- expected
<strong>

=== unclosed strike tag
--- SKIP in md2inao
<s>
--- expected
<s>

=== closed strike
--- in md2inao
<s>ほげほげ</s>
--- expected
<s>ほげほげ</s>

=== closed strike2
--- in md2inao
<strike>ほげほげ</strike>
--- expected
<strike>ほげほげ</strike>

=== closed strike
--- in md2inao
<s>ほげほげ</s>
--- expected
<s>ほげほげ</s>

=== code to inao
--- in md2inao
<code>use strict</code>
--- expected
◆cmd/◆use strict◆/cmd◆

=== strong to inao
--- in md2inao
<strong>突然の死</strong>
--- expected
◆b/◆突然の死◆/b◆

=== span to inao
--- in md2inao
<span class="red">赤字</span>
--- expected
◆red/◆赤字◆/red◆

=== span but unknown class
--- in md2inao
<span class="unknown">unknown</span>
--- expected
<span class="unknown">unknown</span>

=== div but unknown class
--- in md2inao
<div class="unknown">foobar</div>
--- expected chomp
<div class="unknown">foobar</div>
