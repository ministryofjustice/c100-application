$(document).ready(function() {
  document.querySelectorAll(".approx-dob input[type=text]").forEach(function(element){
    setInputFilter(element, function(value) {
      return /^\d*\.?\d*$/.test(value); // Allow digits and '.' only, using a RegExp
    }, "Only digits and '.' are allowed");        
  })
})