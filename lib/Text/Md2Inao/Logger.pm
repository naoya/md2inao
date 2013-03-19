package Text::Md2Inao::Logger;
use strict;
use warnings;

use Encode qw/encode_utf8/;
use Term::ANSIColor;

use parent qw/Exporter/;
our @EXPORT = qw/log/;

our $STOP;

my %COLOR = (
    success => 'green',
    warn    => 'red',
    error   => 'red',
    info    => 'white',
);

sub log ($$) {
    my ($type, $msg) = @_;
    my $color ||= $COLOR{$type};
    if (not $STOP) {
        print STDERR encode_utf8(Term::ANSIColor::colored sprintf("[%s] %s\n", $type, $msg), $color);
    }
    return;
}

1;
