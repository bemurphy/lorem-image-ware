require "lorem-image-ware/version"
require "net/http"
require "uri"

module LoremImageWare
  class LoremPixelProvider
    def initialize(grayscale = false)
      @grayscale = grayscale
    end

    def url(params)
      tag = params[:tag] || "abstract"
      url = ["http://lorempixel.com", @grayscale ? "g" : nil, params[:width], params[:height], tag].compact.join("/")
      url += "/?r=#{rand(20)}"
      url
    end
  end

  module Helpers
    def lorem_image_root
      "/lorem"
    end

    def lorem_image_path(options = {})
      height = options.fetch(:height, 200)
      width  = options.fetch(:width, 400)
      tag    = options.fetch(:tag, "abstract")

      "#{lorem_image_root}/image/#{width}/#{height}/#{tag}?r=#{rand(99)}"
    end

    def lorem_image_tag(options = {})
      height     = options.fetch(:height, 200)
      width      = options.fetch(:width, 400)
      html_class = [options[:class], "lorem-image"].compact.join(" ")

      %Q{<img src="#{lorem_image_path(options)}" class="#{html_class}" width="#{width}" height="#{height}" style="height: #{height}px; width: #{width}px;" />}
    end
  end

  class Middleware
    def initialize(app, options = {})
      @app     = app
      @options = options
    end

    def call(env)
      self.dup._call(env)
    end

    def _call(env)
      request = Rack::Request.new(env)

      if request.fullpath =~ %r{^#{root}/image/(\d+)/(\d+)/?(/(\S+))?}i
        url = provider.url(width: $1, height: $2, tag: $4)
        serve_image(url)
      else
        @app.call(env)
      end
    end

    def serve_image(url)
      if image_data = fetch_image(url)
        Rack::Response.new([], 200, {"Content-Type" => "image/jpeg"}).finish do |res|
          res.write(image_data)
        end
      else
        [404, {"Content-Type" => "test/plain"}, ["Not found"]]
      end
    end

    def fetch_image(url)
      @@image_cache ||= Hash.new do |h, url|
        uri = URI(url)
        res = Net::HTTP.get_response(uri)
        h[url] = res.body if res.code == "200"
      end

      @@image_cache[url]
    end

    def root
      @options.fetch(:root, "/lorem")
    end

    def provider
      @provider ||= @options.fetch(:provider, LoremPixelProvider.new)
    end
  end
end
