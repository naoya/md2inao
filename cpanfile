requires 'Text::Markdown';
requires 'HTML::TreeBuilder';
requires 'Unicode::EastAsianWidth';
requires 'Pod::Usage';
requires 'Class::Accessor::Fast';
requires 'FindBin::libs';
requires 'Term::ANSIColor';

## for web app
# requires 'Mojolicious::Lite';
# requires 'Plack';
# requires 'Server::Starter';
# requires 'Starman';
# requires 'Net::Server::SS::PreFork';

# on 'test' => sub {
#     requires 'Test::More';
#     requires 'Test::Base';
# };

test_requires 'Test::More';
test_requires 'Test::Base';
