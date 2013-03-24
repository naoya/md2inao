package Text::Md2Inao::Node::Div;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

use Text::Md2Inao::Node::Unknown;

sub to_inao {
    my $self = shift;
    my $out = '';

    if ($self->element->attr('class') eq 'column') {
        $self->context->is_column(1);

        # HTMLとして取得してcolumn自信のdivタグを削除
        my $html = $self->element->as_HTML('');
        $html =~ s/^<div.+?>//;
        $html =~ s/<\/div>$//;

        $out .= "◆column/◆\n";
        $out .= $self->context->parse($html);
        $out .= "◆/column◆\n";

        $self->context->is_column(0);
    } else {
        my $node = Text::Md2Inao::Node::Unknown->new({
            context => $self->context,
            element => $self->element
        });
        $out = $node->to_inao;
    }

    return $out;
}

1;
