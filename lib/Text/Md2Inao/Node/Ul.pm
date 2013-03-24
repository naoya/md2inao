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
                $self->context->is_list(1);
                $ret .= sprintf "＊・%s\n", $self->context->parse_inline($_);
                $self->context->is_list(0);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($self->element->content_list) {
            $self->context->is_list(1);
            $ret .= '・' . $self->context->parse_inline($list) . "\n";
            $self->context->is_list(0);
        }
        return $ret;
    }
}

1;
