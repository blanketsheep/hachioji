require 'middleman-core/renderers/redcarpet'

class CustomRedcarpetRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
  
  def postprocess(full_document)
    full_document.gsub(/\[flickr:(.+?)\/(.+)\]/, '<iframe class="flickrembed" src="https://www.flickr.com/photos/\1/\2/player/" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>')
  end
  
end