$(function () {
  $('#form').submit(function () {
    $.ajax('/upload', {
      type: 'post',
      processData: false,
      contentType: false,
      data: new FormData($(this)[0]),
      dataType: 'text'
    }).done(function(data) {
      $('#result').slideDown("fast").find('textarea').val(data);

      // Download Anchor
      var filename = $('#form').find('.fileupload-preview').text().replace(/.md$/, ".txt");
      var blob = new Blob([ data ], {"type": "text/plain"});
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
