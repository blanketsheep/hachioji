(function() {
  var mainPosition, onscroll;

  mainPosition = null;

  onscroll = function() {
    var body, header, headerHeight, position;
    position = $(window).scrollTop();
    body = $('body').eq(0);
    header = $('#header');
    $(body).attr('data-scroll-top', position);
    headerHeight = $(header).height();
    if ((mainPosition != null) && (mainPosition - headerHeight) <= position) {
      return $(body).attr('data-scrolled-main', 'data-scrolled-main');
    } else {
      return $(body).removeAttr('data-scrolled-main');
    }
  };

  $(window).on('scroll', onscroll);

  $(function() {
    mainPosition = $('#mainborder').offset().top;
    console.log(mainPosition);
    return onscroll();
  });

}).call(this);
