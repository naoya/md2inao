package Text::Md2Inao::Builder::DSL;
use strict;
use warnings;

use parent qw/Exporter/;
our @EXPORT = qw/case/;

sub case ($&) {
    my ($select, $code) = @_;
    my $class = (caller)[0];
    my $self = $class->new;
    for (split ",", $select) {
        s/\s+//g;
        $self->dispatch_table->{$_} = $code;
    }
}

1;
