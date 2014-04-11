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
