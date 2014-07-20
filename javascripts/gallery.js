(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

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
      var elm, elmHeight, elmWidth, nw, overlayProjection, se;
      overlayProjection = this.getProjection();
      nw = overlayProjection.fromLatLngToDivPixel(this.bounds_.getSouthWest());
      se = overlayProjection.fromLatLngToDivPixel(this.bounds_.getNorthEast());
      elmWidth = se.x - nw.x;
      elmHeight = se.y - nw.y;
      elm = this.elm_;
      return $(elm).css({
        'left': nw.x + 'px',
        'top': nw.y + 'px',
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
    var locations, map, mapOptions, markers;
    markers = {};
    map = null;
    mapOptions = null;
    locations = null;
    (function() {
      mapOptions = {
        zoom: 17,
        center: new google.maps.LatLng(35.656039, 139.339178),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById('gallery_map'), mapOptions);
      return locations = $('#items .location');
    })();
    return (function() {
      return $(locations).each(function(key, location) {
        var markerId, photos;
        markerId = null;
        (function() {
          var ids, tempId;
          while (true) {
            ids = Object.keys(markers);
            tempId = Math.random().toString();
            if (__indexOf.call(ids, tempId) < 0) {
              markerId = tempId;
              break;
            } else {
              continue;
            }
          }
          return markers[markerId] = {};
        })();
        $(location).attr('data-marker-id', markerId);
        (function() {
          var latLng, marker;
          latLng = new google.maps.LatLng($(location).attr('data-latitude'), $(location).attr('data-longitude'));
          marker = new google.maps.Marker({
            position: latLng,
            map: map,
            title: $(location).attr('data-title')
          });
          google.maps.event.addListener(marker, 'click', function() {
            var attrName, elms, hide, show;
            elms = $('#items .location[data-marker-id]');
            show = null;
            $(elms).each(function(key, elm) {
              if ($(elm).attr('data-marker-id') === markerId) {
                show = elm;
                return false;
              }
            });
            hide = $(elms).not(show);
            attrName = 'data-selected';
            $(hide).removeAttr(attrName);
            $(show).queue(attrName, function() {
              $(show).attr(attrName, '0');
              return $(show).dequeue(attrName);
            }).delay(1, attrName);
            $(show).queue(attrName, function() {
              $(show).attr(attrName, '1');
              return $(show).dequeue(attrName);
            });
            $(show).dequeue(attrName);
            return (function() {
              return $('html,body').animate({
                scrollTop: $('#items').offset().top
              }, 250);
            })();
          });
          return markers[markerId].marker = marker;
        })();
        photos = $('.photo', location);
        return $(photos).each(function(key, photo) {
          var bounds, neBound, overlay, src, swBound;
          swBound = new google.maps.LatLng($(photo).attr('data-nw-latitude'), $(photo).attr('data-nw-longitude'));
          neBound = new google.maps.LatLng($(photo).attr('data-se-latitude'), $(photo).attr('data-se-longitude'));
          bounds = new google.maps.LatLngBounds(swBound, neBound);
          src = $(photo).attr('data-src');
          overlay = new PhotoOverlay(bounds, src, map);
          return markers[markerId].overlay = overlay;
        });
      });
    })();
  });

}).call(this);
