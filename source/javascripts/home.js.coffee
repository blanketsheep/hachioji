$ ->
  (() ->
    container = $('#slide')
    items = $('.slide_item',container)
    onInterval = ->
      nextKey = -1
      oldKey  = -1
      queueName = 'slide'
      #items = $('.slide_item',container)
      oldItem = $(items).filter('[data-is-visible]')
      isFirst = false
      if $(oldItem).size() < 1
        oldKey  = 0
        nextKey = 1
        $(container).attr('data-is-first','data-is-first')
        isFirst = true
      else
        oldKey  = parseInt $(oldItem).attr('data-item-key')
        nextKey = oldKey + 1;
        $(container).removeAttr('data-is-first')
        if $(items).filter('[data-item-key="' + nextKey + '"]').size() < 1
          nextKey = 0
      currentSelector = '[data-item-key="' + oldKey + '"]'
      nextSelector    = '[data-item-key="' + nextKey + '"]'
      $(container).queue queueName, ->
        item = null
        if isFirst
          item = $(items).filter(currentSelector)
        else
          item = $(items).filter(nextSelector)
          
        $(item).attr 'data-is-visible', 'data-is-visible'
        $(@).dequeue(queueName)
      $(container).queue queueName, ->
        item = null
        if isFirst
          item = $(items).not(currentSelector)
        else
          item = $(items).not(nextSelector)
        $(item).removeAttr 'data-is-visible'
        $(@).dequeue(queueName)
      
      $(container).dequeue(queueName)
      setTimeout(onInterval,10000)
    setTimeout(() ->
      #items = $('.slide_item',container)
      $(container).attr('data-item-length',items.length)
      $(items).each (key,item) ->
        $(item).attr('data-item-key',key)
        $(item).removeAttr('data-is-visible')
      onInterval()
    ,100)
  )()