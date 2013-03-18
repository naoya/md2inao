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
=== case 1
--- SKIP in md2inao
<a>
--- expected
<a>

=== case 2
--- in md2inao
<a href="http://www.example.com">example.com</a>
--- expected
example.com◆注/◆http://www.example.com◆/注◆

=== case 3
--- in md2inao
[RubyMotion](http://www.rubymotion.org/)
--- expected
RubyMotion◆注/◆http://www.rubymotion.org/◆/注◆

=== case 4
--- SKIP in md2inao
「<b>」
--- expected
「<b>」

=== case 5
--- SKIP in md2inao
「<a>」
--- expected
「<a>」

=== case 6
--- in md2inao
&lt;strong&gt;
--- expected
<strong>

=== case 7
--- SKIP in md2inao
<s>
--- expected
<s>
