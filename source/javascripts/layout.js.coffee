mainPosition = null

onscroll = ->
  position = $(window).scrollTop()
  body = $('body').eq(0)
  header = $('#header')
  $(body).attr 'data-scroll-top', position
  
  headerHeight = $(header).height()
  
  if mainPosition? and (mainPosition - headerHeight) <= position
    $(body).attr 'data-scrolled-main', 'data-scrolled-main'
  else
    $(body).removeAttr 'data-scrolled-main'

$(window).on 'scroll', onscroll

$ ->
  (() ->
    mainPosition = $('#mainborder').offset().top;
    #console.log mainPosition
    onscroll()
  )()
  (() ->
    attrKey = 'data-expanded'
    isExpandableHeader = ->
      bottom = $('#header').css('bottom').toString()
      if bottom != '0' && bottom != '0px'
        return false
      return true
    $('#header a').on 'click', (e) ->
      header = $('#header')
      isExpanded = $(header).attr attrKey
      if !isExpandableHeader() || isExpanded?
        return true
      if !isExpanded?
        $(header).attr attrKey,attrKey
      else
        $(header).removeAttr attrKey
      return false
  )()