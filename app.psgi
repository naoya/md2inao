#!perl

use Mojolicious::Lite;
use Project::Libs;
use Plack::Builder;
use Encode qw/decode_utf8/;

use Text::Md2Inao;
use Text::Md2Inao::Builder::InDesign;

get '/' => sub {
    my $self = shift;
    $self->render('index', version => $Text::Md2Inao::VERSION);
};

post '/upload' => sub {
    my $self = shift;

    return $self->render(text => 'File is too big.', status => 200)
        if $self->req->is_limit_exceeded;

    return $self->redirect_to('form')
        unless my $file = $self->param('markdown');

    my $md = $file->slurp;
    my $p = Text::Md2Inao->new({
        default_list           => 'disc',
        max_list_length        => 63,
        max_inline_list_length => 55,
        blank_style            => $self->req->param('blank_style'),
    });

    if ($self->req->param('in_design')) {
        my $builder = Text::Md2Inao::Builder::InDesign->new;
        $builder->load_filter_config('./config/id_filter.json');
        $p->builder($builder);
    }
    $self->render(text => $p->parse(decode_utf8 $md), format => 'txt');
};

app->types->type(txt => "text/plain;charset=UTF-8");
app->start;

__DATA__

@@ index.html.ep
% layout 'main';
% title 'Markdown to Inao converter';

%= form_for upload => (enctype => 'multipart/form-data', id => 'form') => begin
  <fieldset>
    <legend>Upload Markdown</legend>
    <label>Select File</label>
    <div class="fileupload fileupload-new" data-provides="fileupload">
      <div class="input-append">
        <div class="uneditable-input span3"><i class="icon-file fileupload-exists"></i> <span class="fileupload-preview"></span></div><span class="btn btn-file"><span class="fileupload-new">Select file</span><span class="fileupload-exists">Change</span><input type="file" name="markdown" /></span><a href="#" class="btn fileupload-exists" id="dismiss" data-dismiss="fileupload">Remove</a>
      </div>
    </div>

    <label for='in_design' class="checkbox">
    %= check_box in_design => 1, id => 'in_design'
    InDesign出力
    </label>
    <select name="blank_style" id="blank_style">
      <option value="half">空行半行アキ</option>
      <option value="full">空行1行アキ</option>
    </select>
    <p><button type="submit" class="btn btn-primary">Convert File</button> <img src="/img/ajax-loader.gif" alt="loading" title="loading" id="indicator"></p>
  </fieldset>
% end

<div id="result">
  <p class="text-right"><a href="" id="download">ダウンロード (Google Chromeのみ)</a></p>
  <textarea id="content"></textarea>
</div>

@@ layouts/main.html.ep
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="utf8">
  <title><%= title %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="/css/bootstrap.min.css" rel="stylesheet">
  <link href="/css/md2inao.css" rel="stylesheet">
</head>
<body>

<div class="container">

<a href="https://github.com/naoya/md2inao.pl"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png" alt="Fork me on GitHub"></a>

<div class="masthead">
  <h3 class="muted">Markdown2Inao</h3>
</div><!-- /.masthead -->

<%= content %>

<hr />

<div class="footer">
  <p class="text-right"><a href="http://github.com/naoya/md2inao.pl">Text::Md2Inao</code> <%= $version %></a> (github)</p>
</div><!-- /.footer -->
</div><!-- /.container -->

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/md2inao.js"></script>
</body>
</html>
