require "builder"

set :layout, :article

activate :livereload

activate :i18n

activate :directory_indexes

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

activate :fjords do |config|
  config.username = Bundler.settings["fjords_username"]
  config.password = Bundler.settings["fjords_password"]
  config.domain = "middlemanapp.com"
  config.gzip_assets = true
  config.cdn = true
end

configure :development do
  activate :relative_assets
end

configure :build do
  activate :minify_css
  activate :minify_javascript
end

class CodeLinker < Middleman::Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    helpers do 
      def link_file(path)
          out = File.open(path) { |f| f.read}  
      end
    end
end
::Middleman::Extensions.register(:code_linker, CodeLinker)

activate :code_linker
activate :google_analytics do |ga|
  ga.tracking_id = 'UA-51025679-3'
end
