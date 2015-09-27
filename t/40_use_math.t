use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== inline math
--- in md2id
UseMath: true

Inline math text $x_1$ and $x_2$ should be preserved as-is.
--- expected
<SJIS-MAC>
<ParaStyle:本文>Inline math text $x_1$ and $x_2$ should be preserved as-is.

=== display math
--- in md2id
UseMath: true

Display math text like following should be kept as-is.

$$
\begin{split}
  x_1, \\
  x_2, \\
  x_3
\end{split}
$$

$$
\begin{split}
  x_4, \\
  x_5
\end{split}
$$

Here is normal markdown text.
--- expected
<SJIS-MAC>
<ParaStyle:本文>Display math text like following should be kept as-is.
<ParaStyle:本文>$$
\begin{split}
  x_1, \\
  x_2, \\
  x_3
\end{split}
$$
<ParaStyle:本文>$$
\begin{split}
  x_4, \\
  x_5
\end{split}
$$
<ParaStyle:本文>Here is normal markdown text.

