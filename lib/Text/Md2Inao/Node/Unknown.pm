package Text::Md2Inao::Node::Unknown;
use strict;
use warnings;
use parent 'Text::Md2Inao::Node';

sub to_inao {
    shift->fallback_to_html;
}

1;
