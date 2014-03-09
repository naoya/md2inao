package Text::Md2Inao::Logger;
use strict;
use warnings;

use Encode qw/encode_utf8/;
use Term::ANSIColor;

use parent qw/Exporter/;
our @EXPORT = qw/log/;

our $LOG;
our $STOP;

my %COLOR = (
    success => 'green',
    warn    => 'red',
    error   => 'red',
    info    => 'white',
);

sub log ($$) {
    my ($type, $msg) = @_;
    if ($LOG) {
        $LOG->($type, $msg);
    }
    elsif (not $STOP) {
        my $color ||= $COLOR{$type};
        print STDERR encode_utf8(Term::ANSIColor::colored sprintf("[%s] %s\n", $type, $msg), $color);
    }
    return;
}

1;
