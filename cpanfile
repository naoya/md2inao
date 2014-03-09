requires 'perl', '5.010_000';
requires 'Text::Markdown::Hoedown';
requires 'HTML::TreeBuilder';
requires 'Unicode::EastAsianWidth';
requires 'Pod::Usage';
requires 'Class::Accessor::Fast';
requires 'FindBin::libs';
requires 'Term::ANSIColor';
requires 'Exporter::Lite';
requires 'Path::Tiny';
requires 'Tie::IxHash';
requires 'JSON', '>= 2.55';
requires 'File::ShareDir';

feature 'psgi', 'web app support' => sub {
    requires 'Project::Libs';
    requires 'Mojolicious::Lite';
    requires 'Plack';
    requires 'Server::Starter';
    requires 'Starman';
    requires 'Net::Server::SS::PreFork';
};

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::LongString';
    requires 'Test::Base';
    requires 'Devel::Cover';
};

on 'development' => sub {
    requires 'Data::Recursive::Encode';
};

on 'configure' => sub {
    requires 'ExtUtils::MakeMaker' => '>= 6.74';
    requires 'ExtUtils::MakeMaker::CPANfile';
    requires 'File::ShareDir::Install';
};

# vim: set ft=perl:
