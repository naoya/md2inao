#!perl

use Mojolicious::Lite;
use Project::Libs;
use Plack::Builder;
use Encode qw/decode_utf8/;

use Text::Md2Inao;

# Increase limit to 1GB from 5MB
# $ENV{MOJO_MAX_MESSAGE_SIZE} = 1073741824;

get '/' => sub {
    shift->render;
} => 'index';

post '/upload' => sub {
    my $self = shift;

    return $self->render(text => 'File is too big.', status => 200)
        if $self->req->is_limit_exceeded;

    return $self->redirect_to('form')
        unless my $md = $self->param('markdown');

    my $size = $md->size;
    my $name = $md->filename;

    my $text = $md->slurp;

    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
    });
    $self->render(text => decode_utf8($p->parse($text)), format => 'txt');
};

app->start;

__DATA__

@@ index.html.ep
<html>
<head>
  <title>Markdown to Inao converter</title>
</head>
<body>

<div id="container">
<div id="main">
<h1>markdown2inao</h1>

%= form_for upload => (enctype => 'multipart/form-data') => begin
  %= file_field 'markdown'
  %= submit_button 'upload markdown file'
%end
</div>
<div id="footer">
  <p><a href="http://github.com/naoya/md2inao.pl">view source on github</a></p>
</div>
</div>

</body>
</html>
