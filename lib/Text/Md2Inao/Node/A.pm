package Text::Md2Inao::Node::A;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $url   = $self->element->attr('href');
    my $title = $self->element->as_trimmed_text;
    if ($url and $title) {
        return sprintf "%s◆注/◆%s◆/注◆", $title, $url;
    } else {
        return $self->fallback_to_html
    }
}

1;
