package Text::Md2Inao::Node::Strong;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    sprintf "◆b/◆%s◆/b◆", shift->element->as_trimmed_text;
}

1;
