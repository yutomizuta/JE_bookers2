$(document).on('turbolinks:load', function() {
  $(function() {
    $('.slider').slick({
        arrows: false,  
        autoplay: true, 
        autoplaySpeed: 50,
    });
  });
});
