require_relative "./test_helper"

class TestHelpers < MiniTest::Unit::TestCase
  include LoremImageWare::Helpers

  def test_default_image_root
    assert_equal "/lorem", lorem_image_root
  end

  def test_default_image_path
    path = lorem_image_path
    assert_match %r{^/lorem/image/400/200/abstract\?r=\d+$}, path
  end

  def test_image_path
    path = lorem_image_path(:height => 50, :width => 100, :tag => "sports")
    assert_match %r{^/lorem/image/100/50/sports\?r=\d+$}, path
  end

  def test_image_tag
    image_tag = lorem_image_tag(:height => 50, :width => 100, :tag => "sports", :class => "klass")
    assert_match %r{<img src="/lorem/image/100/50/sports\?r=\d+" class="klass lorem-image" width="100" height="50" style="height: 50px; width: 100px;" />}, image_tag
  end
end
