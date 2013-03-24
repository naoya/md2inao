package Text::Md2Inao::Node::Ul;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    if ($self->context->in_list) {
        my $ret = "\n";
        for ($self->element->content_list) {
            if ($_->tag eq 'li') {
                $ret .= sprintf "＊・%s\n", $self->context->parse_element($_);
            }
        }
        chomp $ret;
        return $ret;
    } else {
        my $ret;
        for my $list ($self->element->content_list) {
            $self->context->in_list(1);
            $ret .= '・' . $self->context->parse_element($list) . "\n";
            $self->context->in_list(0);
        }
        return $ret;
    }
}

1;
