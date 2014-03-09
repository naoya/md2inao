package Text::Md2Inao::Director;
use strict;
use warnings;

use Carp;
use Class::Accessor::Fast qw/antlers/;

has builder => ( is => 'rw', isa => 'Text::Md2Inao::Builder' );

sub new {
    my ($class, $builder) = @_;
    return $class->SUPER::new({ builder => $builder });
}

sub process {
    my ($self, $c, $h) = @_;
    my $select = ref $h eq '' ? 'text' : $h->tag;
    my $proc = $self->builder->dispatch($select) or croak("Missing case: $select");
    $proc->($c, $h);
}

sub process_before_filter {
    my ($self, $c, $in) = @_;
    return $self->builder->before_filter($c, $in);
}

sub process_after_filter {
    my ($self, $c, $out) = @_;
    return $self->builder->after_filter($c, $out);
}

1;
