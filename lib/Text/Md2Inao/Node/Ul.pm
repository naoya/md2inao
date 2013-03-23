package Text::Md2Inao::Node::Ul;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    if ($self->context->is_inline) {
        my $ret = "\n";
        for ($self->element->content_list) {
            if ($_->tag eq 'li') {
                $ret .= sprintf "＊・%s\n", $self->context->parse_inline($_, 1);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($self->element->content_list) {
            $ret .= '・' . $self->context->parse_inline($list, 1) . "\n";
        }
        return $ret;
    }
}

1;
