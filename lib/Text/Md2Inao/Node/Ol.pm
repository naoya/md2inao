package Text::Md2Inao::Node::Ol;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';
use Text::Md2Inao::Util qw/to_list_style/;

sub to_inao {
    my $self = shift;
    my $out = '';

    my $list_style = $self->element->attr('class') || $self->context->default_list;
    my $s = substr $list_style, 0, 1;
    my $i = 0;
    for my $list ($self->element->find('li')) {
        $out .= to_list_style((sprintf '(%s%d)', $s, ++$i) . $self->context->parse_inline($list, 1)) . "\n";
    }

    return $out;
}

1;

