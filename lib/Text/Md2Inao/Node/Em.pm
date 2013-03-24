package Text::Md2Inao::Node::Em;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;
use parent 'Text::Md2Inao::Node';

has special_italic => ( is => 'rw');

sub to_inao {
    my $self = shift;
    my $ret;
    $ret .= $self->context->use_special_italic ? '◆i-j/◆' : '◆i/◆';
    $ret .= $self->element->as_trimmed_text;
    $ret .= $self->context->use_special_italic ? '◆/i-j◆' : '◆/i◆';
    return $ret;
}

1;
