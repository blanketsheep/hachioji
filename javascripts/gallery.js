(function() {
  (function() {
    this.PhotoOverlay = function(bounds, image, map) {
      this.bounds_ = bounds;
      this.image_ = image;
      this.map_ = map;
      this.elm_ = null;
      return this.setMap(map);
    };
    this.PhotoOverlay.prototype = new google.maps.OverlayView();
    this.PhotoOverlay.prototype.onAdd = function() {
      var elm, img, panes;
      elm = document.createElement('div');
      $(elm).css({
        'position': 'absolute',
        'background-color': '#fff',
        'box-shadow': '0 1px 3px #000',
        'background-image': 'url(' + this.image_ + ')',
        'background-size': 'contain',
        'background-repeat': 'no-repeat',
        'background-position': 'center center'
      });
      img = document.createElement('img');
      $(img).attr('src', this.image_);
      $(img).css({
        'width': '100%',
        'height': '100%',
        'display': 'none'
      });
      $(elm).append(img);
      this.elm_ = elm;
      panes = this.getPanes();
      return $(panes.overlayLayer).append(elm);
    };
    this.PhotoOverlay.prototype.draw = function() {
      var elm, elmHeight, elmWidth, ne, overlayProjection, sw;
      overlayProjection = this.getProjection();
      sw = overlayProjection.fromLatLngToDivPixel(this.bounds_.getSouthWest());
      ne = overlayProjection.fromLatLngToDivPixel(this.bounds_.getNorthEast());
      elmWidth = ne.x - sw.x;
      elmHeight = ne.y - sw.y;
      elm = this.elm_;
      return $(elm).css({
        'left': sw.x + 'px',
        'top': sw.y + 'px',
        'width': elmWidth + 'px',
        'height': elmHeight + 'px'
      });
    };
    return this.PhotoOverlay.prototype.onRemove = function() {
      this.elm_.parentNode.removeChild(this.elm_);
      return this.elm_ = null;
    };
  })();

  $(function() {
    return (function() {
      var locations, map, mapOptions;
      mapOptions = {
        zoom: 17,
        center: new google.maps.LatLng(35.665726, 139.281587),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById('gallery_map'), mapOptions);
      locations = $('#items .location');
      return $(locations).each(function(key, location) {
        var photos;
        photos = $('.photo', location);
        return $(photos).each(function(key, photo) {
          var bounds, neBound, overlay, src, swBound;
          swBound = new google.maps.LatLng($(photo).attr('data-sw-latitude'), $(photo).attr('data-sw-longitude'));
          neBound = new google.maps.LatLng($(photo).attr('data-ne-latitude'), $(photo).attr('data-ne-longitude'));
          bounds = new google.maps.LatLngBounds(swBound, neBound);
          src = $(photo).attr('data-src');
          return overlay = new PhotoOverlay(bounds, src, map);
        });
      });
    })();
  });

}).call(this);
