require 'middleman-core/renderers/redcarpet'

class CustomRedcarpetRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
  
  def preprocess(full_document)
    full_document.gsub(/^\[flickr:(.+?)\]$/, '<div class="image_box_wrapper"><div class="image_box"><div class="container"><iframe class="flickrembed" src="https://www.flickr.com/photos/\1/player/" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe></div></div></div>')
  end
  
end