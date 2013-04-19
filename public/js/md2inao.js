$(function () {
  $('#form').submit(function () {
    $.ajax('/upload', {
      type: 'post',
      processData: false,
      contentType: false,
      data: new FormData($(this)[0]),
      dataType: 'text'
    }).done(function(data) {
      console.log(data);
      $('#result').val(data).slideDown("fast");
    }).fail(function(data) {
      alert('Failed to upload');
      console.log(data);
    });

    return false;
  });

  $('#dismiss').on('click', function() {
    $('#result').val('').slideUp("fast");
  });

  $('#result').on('click', function() {
    this.selectionStart = 0;
    this.selectionEnd = this.value.length;
  });
});