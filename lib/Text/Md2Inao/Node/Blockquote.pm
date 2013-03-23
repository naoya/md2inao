package Text::Md2Inao::Node::Blockquote;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $blockquote = '';
    for my $p ($self->element->content_list) {
        $blockquote .= $self->context->parse_inline($p, 1);
    }
    $blockquote =~ s/(\s)//g;

    return <<EOF;
◆quote/◆
$blockquote
◆/quote◆
EOF
}

1;
