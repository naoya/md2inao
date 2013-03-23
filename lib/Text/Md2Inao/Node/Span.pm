package Text::Md2Inao::Node::Span;
use utf8;
use strict;
use warnings;
use feature 'switch';

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    given ($self->element->attr('class')) {
        when ('red') {
            return sprintf "◆red/◆%s◆/red◆",    $self->element->as_trimmed_text;
        }
        when ('ruby') {
            my $ruby = $self->element->as_trimmed_text;
            $ruby =~ s!(.+)\((.+)\)!◆ルビ/◆$1◆$2◆/ルビ◆!;
            return $ruby;
        }
        when ('symbol') {
            return sprintf "◆%s◆",$self->element->as_trimmed_text;
        }
        default {
            return $self->fallback_to_html;
        }
    }
}

1;
