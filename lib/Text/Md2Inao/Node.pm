package Text::Md2Inao::Node;
use utf8;
use strict;
use warnings;

use Class::Accessor::Fast qw/antlers/;
use Text::Md2Inao::Logger;

has element => ( is => 'rw', isa => 'HTML::Element');

sub fallback_to_html {
    my $self = shift;
    log warn => sprintf "HTMLタグは `<%s>` でエスケープしてください。しない場合の出力は不定です", $self->element->tag;
    return $self->element->as_HTML('', '', {});
}

sub to_inao {}

1;
