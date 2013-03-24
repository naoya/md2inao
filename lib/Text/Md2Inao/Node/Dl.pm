package Text::Md2Inao::Node::Dl;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $out = '';
    for ($self->element->descendants) {
        if ($_->tag eq 'dt') {
            $out .= sprintf "・%s\n", $self->context->parse_element($_);
        } elsif ($_->tag eq 'dd') {
            $out .= sprintf "・・%s\n", $self->context->parse_element($_);
        }
    }
    return $out;
}

1;
