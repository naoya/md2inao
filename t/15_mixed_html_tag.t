use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== multi-line HTML tags
--- in md2inao
foo
bar
<div class="undefined">baz</div>
--- expected
foobar<div class="undefined">baz</div>

=== multi-line HTML tags with empty lines
--- in md2inao
foo

bar

<div class="undefined">baz</div>
--- expected chomp
foo
bar
<div class="undefined">baz</div>

