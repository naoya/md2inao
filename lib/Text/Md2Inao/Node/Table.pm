package Text::Md2Inao::Node::Table;
use utf8;
use strict;
use warnings;

use parent 'Text::Md2Inao::Node';

sub to_inao {
    my $self = shift;
    my $out = '';
    my $summary = $self->element->attr('summary') || '';
    $summary =~ s!(.+?)::(.+)!●$1\t$2\n!;
    $out .= "◆table/◆\n";
    $out .= $summary;
    $out .= "◆table-title◆";
    for my $table ($self->element->find('tr')) {
        for my $item ($table->find('th')) {
            $out .= $item->as_trimmed_text;
            $out .= "\t";
        }
        for my $item ($table->find('td')) {
            $out .= $item->as_trimmed_text;
            $out .= "\t";
        }
        chop($out);
        $out .= "\n"
    }
    $out .= "◆/table◆\n";
    return $out;
}

1;
