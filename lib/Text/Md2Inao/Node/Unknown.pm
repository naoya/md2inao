package Text::Md2Inao::Node::Unknown;
use strict;
use warnings;
use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $out = $self->fallback_to_html;
    if ($self->context->is_block) {
        $out .= "\n";
    }
    return $out;
}

1;
