use strict;
use warnings;
use Test::More;

use Text::Md2Inao;

sub slurp {
    my $file = shift;
    open my $fh, '<', $file or die $!;
    my $text = do { local $/; <$fh> };
    close $fh;
    return $text;
}

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

my $out    = $p->parse(slurp "./t/x_input.txt");
my $origin = slurp("./t/x_output.txt");

is length $origin, length $out;

done_testing;
