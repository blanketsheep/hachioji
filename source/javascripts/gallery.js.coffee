(() ->
  @PhotoOverlay = (bounds, image, map) ->
    @bounds_ = bounds
    @image_  = image
    @map_    = map
    @elm_    = null
    @.setMap map
  
  @PhotoOverlay.prototype = new google.maps.OverlayView();
  
  @PhotoOverlay.prototype.onAdd = () ->
    elm = document.createElement 'div'
    $(elm).css
      'position': 'absolute'
      'background-color': '#fff'
      'box-shadow': '0 1px 3px #000'
      'background-image': 'url(' + @image_ + ')'
      'background-size': 'contain'
      'background-repeat': 'no-repeat'
      'background-position': 'center center'
    
    img = document.createElement 'img'
    $(img).attr 'src', @image_
    $(img).css
      'width':  '100%'
      'height': '100%'
      'display': 'none'
    #img.style.position = 'absolute'
    
    $(elm).append img
    
    @elm_ = elm
    
    panes = @.getPanes()
    $(panes.overlayLayer).append elm
  
  @PhotoOverlay.prototype.draw = () ->
    overlayProjection = @.getProjection()
    #sw = overlayProjection.fromLatLngToDivPixel @.bounds_.getSouthWest()
    nw = overlayProjection.fromLatLngToDivPixel @.bounds_.getSouthWest()
    #ne = overlayProjection.fromLatLngToDivPixel @.bounds_.getNorthEast()
    se = overlayProjection.fromLatLngToDivPixel @.bounds_.getNorthEast()
    
    elmWidth  = (se.x - nw.x)
    elmHeight = (se.y - nw.y)
    
    #if elmWidth > elmHeight
    #  elmWidth = elmHeight
    #else
    #  elmHeight = elmWidth
    
    elm = @elm_
    $(elm).css
      'left':   nw.x + 'px'
      'top':    nw.y + 'px'
      'width':  elmWidth  + 'px'
      'height': elmHeight + 'px'
  
  @PhotoOverlay.prototype.onRemove = () ->
    @elm_.parentNode.removeChild @elm_
    @elm_ = null
)()
$ ->
  (() ->
    mapOptions = 
      #zoom: 13
      zoom: 17
      #center: new google.maps.LatLng 35.659475, 139.287093
      center: new google.maps.LatLng 35.656039, 139.339178
      mapTypeId: google.maps.MapTypeId.ROADMAP
    
    map = new google.maps.Map document.getElementById('gallery_map'), mapOptions
    
    #swBound = new google.maps.LatLng 35.664835, 139.282848
    #neBound = new google.maps.LatLng 35.664656, 139.283664
    #bounds  = new google.maps.LatLngBounds swBound, neBound
    #src = 'http://localhost:4567/resources/2014-05-09-test/DSC_5717.JPG'
    #overlay = new PhotoOverlay bounds, src, map
    
    locations = $('#items .location')
    $(locations).each (key, location) ->
      photos = $('.photo',location)
      $(photos).each (key,photo) ->
        swBound = new google.maps.LatLng $(photo).attr('data-nw-latitude'), $(photo).attr('data-nw-longitude')
        neBound = new google.maps.LatLng $(photo).attr('data-se-latitude'), $(photo).attr('data-se-longitude')
        bounds  = new google.maps.LatLngBounds swBound, neBound
        
        src = $(photo).attr 'data-src'
        
        overlay = new PhotoOverlay bounds, src, map
  )()