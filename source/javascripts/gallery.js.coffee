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
  markers = {}
  map = null
  mapOptions = null
  locations = null
  (() ->
    mapOptions = 
      #zoom: 13
      zoom: 17
      #center: new google.maps.LatLng 35.659475, 139.287093
      center: new google.maps.LatLng 35.656039, 139.339178
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map document.getElementById('gallery_map'), mapOptions
    locations = $('#items .location')
  )()
  (() ->
    $(locations).each (key, location) ->
      markerId = null
      (() ->
        while true
          ids = Object.keys markers
          tempId = Math.random().toString()
          if tempId not in ids
            markerId = tempId
            break
          else
            continue
        markers[ markerId ] = {}
      )()
      $(location).attr 'data-marker-id', markerId
      (() ->
        latLng = new google.maps.LatLng $(location).attr('data-latitude'), $(location).attr('data-longitude')
        marker = new google.maps.Marker({
          position: latLng,
          map: map,
          title: $(location).attr('data-title')
        })
        google.maps.event.addListener marker, 'click', () ->
          elms = $('#items .location[data-marker-id]')
          show = null
          $(elms).each (key,elm) ->
            if $(elm).attr('data-marker-id') == markerId
              show = elm
              return false
#          show = $('[data-marker-id="' + markerId + '"]',elms)
          hide = $(elms).not(show)
          
          attrName = 'data-selected'
          
#          $(hide).queue attrName, () ->
#            $(hide).attr attrName, '0'
#            $(hide).dequeue attrName
#          .delay 1, attrName
#          $(hide).queue attrName, () ->
#            $(hide).removeAttr(attrName)
#            $(hide).dequeue attrName
#          $(hide).dequeue attrName
          $(hide).removeAttr(attrName)
          
          $(show).queue attrName, () ->
            $(show).attr attrName, '0'
            $(show).dequeue attrName
          .delay 1, attrName
          $(show).queue attrName, () ->
            $(show).attr attrName, '1'
            $(show).dequeue attrName
          $(show).dequeue attrName
          
        markers[ markerId ].marker = marker
      )()
      photos = $('.photo',location)
      $(photos).each (key,photo) ->
        swBound = new google.maps.LatLng $(photo).attr('data-nw-latitude'), $(photo).attr('data-nw-longitude')
        neBound = new google.maps.LatLng $(photo).attr('data-se-latitude'), $(photo).attr('data-se-longitude')
        bounds  = new google.maps.LatLngBounds swBound, neBound
        src = $(photo).attr 'data-src'
        overlay = new PhotoOverlay bounds, src, map
        markers[ markerId ].overlay = overlay
  )()