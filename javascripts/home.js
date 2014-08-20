(function() {
  $(function() {
    return (function() {
      var container, items, onInterval;
      container = $('#slide');
      items = $('.slide_item', container);
      onInterval = function() {
        var currentSelector, isFirst, nextKey, nextSelector, oldItem, oldKey, queueName;
        nextKey = -1;
        oldKey = -1;
        queueName = 'slide';
        oldItem = $(items).filter('[data-is-visible]');
        isFirst = false;
        if ($(oldItem).size() < 1) {
          oldKey = 0;
          nextKey = 1;
          $(container).attr('data-is-first', 'data-is-first');
          isFirst = true;
        } else {
          oldKey = parseInt($(oldItem).attr('data-item-key'));
          nextKey = oldKey + 1;
          $(container).removeAttr('data-is-first');
          if ($(items).filter('[data-item-key="' + nextKey + '"]').size() < 1) {
            nextKey = 0;
          }
        }
        currentSelector = '[data-item-key="' + oldKey + '"]';
        nextSelector = '[data-item-key="' + nextKey + '"]';
        $(container).queue(queueName, function() {
          var item;
          item = null;
          if (isFirst) {
            item = $(items).filter(currentSelector);
          } else {
            item = $(items).filter(nextSelector);
          }
          $(item).attr('data-is-visible', 'data-is-visible');
          return $(this).dequeue(queueName);
        });
        $(container).queue(queueName, function() {
          var item;
          item = null;
          if (isFirst) {
            item = $(items).not(currentSelector);
          } else {
            item = $(items).not(nextSelector);
          }
          $(item).removeAttr('data-is-visible');
          return $(this).dequeue(queueName);
        });
        $(container).dequeue(queueName);
        return setTimeout(onInterval, 10000);
      };
      return setTimeout(function() {
        $(container).attr('data-item-length', items.length);
        $(items).each(function(key, item) {
          $(item).attr('data-item-key', key);
          return $(item).removeAttr('data-is-visible');
        });
        return onInterval();
      }, 100);
    })();
  });

}).call(this);
