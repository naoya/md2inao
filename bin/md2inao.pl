#!/usr/bin/env perl
use strict;
use warnings;

use Encode;
use Pod::Usage;
use File::Spec;
use FindBin::libs;
use Getopt::Long qw/:config posix_default no_ignore_case bundling auto_help/;

use Text::Md2Inao;

GetOptions(
    'output-encoding=s' => \my $output_encoding,
) or pod2usage(-1);

my $infile  = $ARGV[0]
    or pod2usage(-1);

open my $fh, '<:utf8', $infile or die $!;
my $text = do { local $/; <$fh> };
close $fh;

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
});

print encode($output_encoding // 'utf-8', $p->parse($text));

__END__

=head1 NAME

md2inao.pl - markdown to inao-format converter for WEB+DB PRESS

=head1 SYNOPSIS

    md2inao.pl [--output-encoding=utf-8] your_markdown_text.md > inao_format.txt
=cut
