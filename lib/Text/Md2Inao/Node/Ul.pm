package Text::Md2Inao::Node::Ul;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $ret = "\n";
    for ($self->element->content_list) {
        if ($_->tag eq 'li') {
            # FIXME: $self->parse_inline() ここどうするか?
            $ret .= sprintf "＊・%s\n", $self->parse_inline($_, 1);
        }
    }
    chomp $ret;
}

1;
