package Text::Md2Inao::Node::Code;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    sprintf "◆cmd/◆%s◆/cmd◆" ,shift->element->as_trimmed_text;
}

1;
