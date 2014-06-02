require "susy"
require "tzinfo"

Time.zone = "Asia/Tokyo"
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, tables: true, smartypants: true
activate :i18n, :path => "/:locale/", :mount_at_root => :ja
set :relative_links, true
set :slim, :pretty => true, :sort_attrs => false, :format => :html5

# Use relative URLs
activate :relative_assets

activate :blog do |blog|
  blog.layout = "blog"
  blog.sources   = "{year}-{month}-{day}-{title}.html"
  blog.prefix    = "articles"
  blog.permalink = "/:year/:month/:day/:title.html"
  blog.summary_separator = /!READMORE/
end

activate :deploy do |deploy|
  deploy.build_before = false
  deploy.method = :git
  deploy.remote = 'git@github.com:blanketsheep/hachioji.git'
  deploy.branch = 'gh-pages'
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

after_configuration do
  sprockets.append_path '../vendor/bower_components/'
end
