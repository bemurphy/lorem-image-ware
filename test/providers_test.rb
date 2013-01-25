require_relative "./test_helper"

class TestLoremPixelProvider < MiniTest::Unit::TestCase
  def test_basic_color_url
    provider = LoremImageWare::LoremPixelProvider.new
    url = provider.url(width: 400, height: 200)
    assert_match %r{http://lorempixel.com/400/200/abstract/\?r=\d+$}, url
  end

  def test_optional_type
    provider = LoremImageWare::LoremPixelProvider.new
    url = provider.url(width: 200, height: 100, type: "sports")
    assert_match %r{http://lorempixel.com/200/100/sports/\?r=\d+$}, url
  end

  def test_grayscale_url
    provider = LoremImageWare::LoremPixelProvider.new(:grayscale)
    url = provider.url(width: 200, height: 100)
    assert_match %r{http://lorempixel.com/g/200/100/abstract/\?r=\d+$}, url
  end
end
