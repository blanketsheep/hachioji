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
    (function() {
      mainPosition = $('#mainborder').offset().top;
      return onscroll();
    })();
    return (function() {
      var attrKey, isExpandableHeader;
      attrKey = 'data-expanded';
      isExpandableHeader = function() {
        var bottom;
        bottom = $('#header').css('bottom').toString();
        if (bottom !== '0' && bottom !== '0px') {
          return false;
        }
        return true;
      };
      return $('#header a').on('click', function(e) {
        var header, isExpanded;
        header = $('#header');
        isExpanded = $(header).attr(attrKey);
        if (!isExpandableHeader() || (isExpanded != null)) {
          return true;
        }
        if (isExpanded == null) {
          $(header).attr(attrKey, attrKey);
        } else {
          $(header).removeAttr(attrKey);
        }
        return false;
      });
    })();
  });

}).call(this);
