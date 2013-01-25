# Lorem::Image::Ware

Rack middleware for proxying requests to [lorempixel.com](http://lorempixel.com)

This mounts routing in your Rack stack so that paths like `/lorem/image/400/200` will
serve a 400x200 random image from lorempixel.com.

The middleware is primarily useful because it will cache responses from lorempixel so
that after a few page loads, images should load much faster.  Without such local
caching you will be stuck hammering their server on every page load, and waiting a
few seconds for images to fill in.

It is recommended to only load the middleware in development environtments.

## Installation

Add this line to your application's Gemfile:

    gem 'lorem-image-ware'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lorem-image-ware

## Usage

Mount in your app stack like:

```ruby
use LoremImageWare::Middleware
```

If you wish to serve off a directory other than the default `/lorem`, pass the `:root` option:

```ruby
use LoremImageWare::Middleware, :root => "/random_images"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
