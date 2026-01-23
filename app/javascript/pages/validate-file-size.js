'use strict';

window.validateFiles = function(inputFile) {
  var maxExceededMessage = "This file is too big. You will need to resubmit a smaller version, less than 20 megabytes (MB)";

  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;

  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
  });
  if (sizeExceeded) {
    $('#file-size-error').removeClass('hidden');
    $('#other-errors').addClass('hidden');
    $(inputFile).val('');
  } else {
    $('#file-size-error').addClass('hidden');
  }
};
