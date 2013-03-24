package Text::Md2Inao::Node::Blockquote;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    $self->context->in_quote_block(1);
    my $blockquote = '';
    for ($self->element->content_list) {
        $blockquote .= $self->context->parse_element($_);
    }
    $blockquote =~ s/(\s)//g;
    $self->context->in_quote_block(0);

    return <<EOF;
◆quote/◆
$blockquote
◆/quote◆
EOF
}

1;
