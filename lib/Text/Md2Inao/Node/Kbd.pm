package Text::Md2Inao::Node::Kbd;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    sprintf "%s▲" ,shift->element->as_trimmed_text;
}

1;
