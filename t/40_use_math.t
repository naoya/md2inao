use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

plan tests => 1 * blocks;
run_is in => 'expected';

__END__
=== inline math indesign
--- in md2id
UseMath: true

Inline math text $x_1$ and $x_2$ should be preserved as-is.
--- expected
<SJIS-MAC>
<ParaStyle:本文>Inline math text $x_1$ and $x_2$ should be preserved as-is.

=== inline math inao
--- in md2inao
UseMath: true

Inline math text $x_1$ and $x_2$ should be preserved as-is.
--- expected
Inline math text $x_1$ and $x_2$ should be preserved as-is.

=== display math indesign
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

=== display math inao
--- in md2inao
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
=== UseMath not specified
--- in md2id
Math texts are converted as Markdown without specifying UseMath.

$x_1$
This place is italic
$x_2$
This place is not italic.

$$ x_1 $$

This place is not italic.

$$ x_2, x_3 $$
--- expected
<SJIS-MAC>
<ParaStyle:本文>Math texts are converted as Markdown without specifying UseMath.
<ParaStyle:本文>$x<CharStyle:イタリック>1$This place is italic$x<CharStyle:>2$This place is not italic.
<ParaStyle:本文>$$ x_1 $$
<ParaStyle:本文>This place is not italic.
<ParaStyle:本文>$$ x<CharStyle:イタリック>2, x<CharStyle:>3 $$
