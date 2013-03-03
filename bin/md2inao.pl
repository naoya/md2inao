#!perl
use strict;
use warnings;

use Pod::Usage;
use File::Spec;
use FindBin::libs;

use Text::Md2Inao;

my $infile  = $ARGV[0]
    or pod2usage(-1);

open my $fh, '<', $infile or die $!;
my $text = do { local $/; <$fh> };
close $fh;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

print $p->parse($text);

__END__

=head1 NAME

md2inao.pl - markdown to inao converter

=head1 SYNOPSIS

    md2inao.pl your_markdown_text.md > inao_format.txt

=cut
