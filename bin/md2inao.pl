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
    'format=s' => \my $format,
) or pod2usage(-1);

my $infile  = $ARGV[0]
    or pod2usage(-1);

open my $fh, '<:utf8', $infile or die $!;
my $text = do { local $/; <$fh> };
close $fh;

my $builder;
if (!$format || $format eq 'in_design') {
    require Text::Md2Inao::Builder::InDesign;
    $builder = Text::Md2Inao::Builder::InDesign->new;
    $builder->load_filter_config('./config/id_filter.json');
} elsif ($format eq 'inao') {
    require Text::Md2Inao::Builder::Inao;
    $builder = Text::Md2Inao::Builder::Inao->new;
} elsif ($format eq 'html') {
    require Text::Md2Inao::Builder::Html;
    $builder = Text::Md2Inao::Builder::Html->new;
}
else {
    die "Unknown format (must be in_desing, inao or html): $format\n";
}

my $p = Text::Md2Inao->new({
    default_list           => 'disc',
    max_list_length        => 63,
    max_inline_list_length => 55,
    builder                => $builder,
});

print encode($output_encoding // 'utf-8', $p->parse($text));

__END__

=head1 NAME

md2inao.pl - markdown to inao-format converter for WEB+DB PRESS

=head1 SYNOPSIS

    md2inao.pl [--format=in_design|html|inao] your_markdown_text.md > inao_format.txt
=cut
