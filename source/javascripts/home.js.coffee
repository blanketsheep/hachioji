$ ->
  (() ->
    container = $('#slide')
    items = $('.slide_item',container)
    (() ->
      #items = $('.slide_item',container)
      $(container).attr('data-item-length',items.length)
      $(items).each (key,item) ->
        $(item).attr('data-item-key',key)
        $(item).removeAttr('data-is-visible')
    )()
    onInterval = ->
      nextKey = -1
      oldKey  = -1
      queueName = 'slide'
      #items = $('.slide_item',container)
      oldItem = $(items).filter('[data-is-visible]')
      if $(oldItem).size() < 1
        oldKey  = 0
        nextKey = 1
        $(container).attr('data-is-first','data-is-first')
      else
        oldKey  = parseInt $(oldItem).attr('data-item-key')
        nextKey = oldKey + 1;
        $(container).removeAttr('data-is-first')
        if $(items).filter('[data-item-key="' + nextKey + '"]').size() < 1
          nextKey = 0
      nextSelector = '[data-item-key="' + nextKey + '"]'
      $(container).queue queueName, ->
        item = $(items).filter(nextSelector)
        $(item).attr 'data-is-visible', 'data-is-visible'
        $(@).dequeue(queueName)
      $(container).queue queueName, ->
        item = $(items).not(nextSelector)
        $(item).removeAttr 'data-is-visible'
        $(@).dequeue(queueName)
      $(container).dequeue(queueName)
      setTimeout(onInterval,10000)
    onInterval()
  )()