---
---
$(window).on 'scroll', ->
	positionx = $(window).scrollTop()
	body = $('body').eq(0)
	$(body).attr 'data-scroll-y',positionx
	
	headerHeight = $('#header').height()
	headerFlag = 'data-scroll-header'
	if positionx >= headerHeight
		$(body).attr headerFlag,headerFlag
	else
		$(body).removeAttr headerFlag

$ ->
	selectors = ['#navtoggle a','#nav'].join(', ')
	$(selectors).on 'click', ->
		body = $('body').eq(0)
		openedFlag = 'data-overlay-opened'
		
		isOpened = $(body).attr openedFlag
		if !isOpened?
			$(body).attr(openedFlag,openedFlag)
		else
			$(body).removeAttr(openedFlag)
	$('#nav>.container>*').on 'click', (e) ->
		e.stopPropagation()
