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
    sw = overlayProjection.fromLatLngToDivPixel @.bounds_.getSouthWest()
    ne = overlayProjection.fromLatLngToDivPixel @.bounds_.getNorthEast()
    
    elmWidth  = (ne.x - sw.x)
    elmHeight = (ne.y - sw.y)
    
    #if elmWidth > elmHeight
    #  elmWidth = elmHeight
    #else
    #  elmHeight = elmWidth
    
    elm = @elm_
    $(elm).css
      'left':   sw.x + 'px'
      'top':    sw.y + 'px'
      'width':  elmWidth  + 'px'
      'height': elmHeight + 'px'
  
  @PhotoOverlay.prototype.onRemove = () ->
    @elm_.parentNode.removeChild @elm_
    @elm_ = null
)()
$ ->
  (() ->
    mapOptions = 
      zoom: 13
      #center: new google.maps.LatLng 35.659475, 139.287093
      center: new google.maps.LatLng 35.665726, 139.281587
      mapTypeId: google.maps.MapTypeId.ROADMAP
    
    map = new google.maps.Map document.getElementById('gallery_map'), mapOptions
    
    swBound = new google.maps.LatLng 35.664835, 139.282848
    neBound = new google.maps.LatLng 35.664656, 139.283664
    bounds  = new google.maps.LatLngBounds swBound, neBound
    
    src = 'http://localhost:4567/resources/2014-05-09-test/DSC_5717.JPG'
    
    overlay = new PhotoOverlay bounds, src, map
  )()