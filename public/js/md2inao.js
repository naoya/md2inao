$(function () {
  $('#form').submit(function () {
    $.ajax('/upload', {
      type: 'post',
      processData: false,
      contentType: false,
      data: new FormData($(this)[0]),
      dataType: 'json'
    }).done(function(data) {
      $('#result').slideDown("fast").find('textarea').val(data.content);

      var error = $('#error');
      error.empty();
      for (var i = 0; i < data.errors.length; ++i) {
        var element = $('<pre/>');
        element.addClass(data.errors[i].type);
        element.text(data.errors[i].message);
        error.append(element);
      }
      $('#error').slideDown("fast").find('textarea').val(data.error);

      // Download Anchor
      var filename = $('#form').find('.fileupload-preview').text().replace(/.md$/, ".txt");
      var blob = new Blob([ data.content ], {"type": "text/plain"});
      window.URL = window.URL || window.webkitURL;
      $('#download').attr("href", window.URL.createObjectURL(blob)).attr("download", filename);
    }).fail(function(data) {
      alert('Failed to upload');
      console.log(data);
    });

    return false;
  });

  $(document).ajaxStart(function () {
    $('#indicator').show();
  });
  
  $(document).ajaxStop(function () {
    $('#indicator').hide();
  });
  

  $('#dismiss').on('click', function() {
    $('#result').slideUp("fast").find('textarea').val('');
  });

  $('#content').on('click', function() {
    this.selectionStart = 0;
    this.selectionEnd = this.value.length;
  });

  $('#in_design').on('change', function() {
    $('#blank_style').toggle();
  });
});
// vim: set tabstop=2 expandtab:
