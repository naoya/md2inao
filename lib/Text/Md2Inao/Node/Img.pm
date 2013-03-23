package Text::Md2Inao::Node::Img;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

my $img_number = 0;

sub to_inao {
    my $self = shift;
    return sprintf (
        "●図%d\t%s\n%s\n",
        ++$img_number,
        $self->element->attr('alt') || $self->element->attr('title'),
        $self->element->attr('src')
    );
}

1;
