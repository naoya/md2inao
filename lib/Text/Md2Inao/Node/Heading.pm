package Text::Md2Inao::Node::Heading;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $out = '';
    if ($self->element->tag =~ /^h(\d+)$/) {
        my $level = $1;
        $out .= '■' x $level;
        $out .= $self->element->as_trimmed_text;
        $out .= "\n";
    }
    return $out;
}

1;
