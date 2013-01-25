require_relative "./test_helper"
require "ostruct"

class TestMiddleware < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use LoremImageWare::Middleware
      run lambda { |env| [200, { 'Content-Type' => "text/plain" }, ["path = #{env['PATH_INFO']}"]] }
    end
  end

  def test_root
    get "/"
    assert_equal "path = /", last_response.body
  end

  def test_hello
    get "/hello"
    assert_equal "path = /hello", last_response.body
  end

  def test_width_and_height
    get "/lorem/image/400/200"
    assert_equal 200, last_response.status
    assert_equal "image/jpeg", last_response.headers["Content-Type"]
    assert last_response.headers["Content-Length"]
    assert last_response.headers["Content-Length"].to_i > 0
  end

  def test_tag_param
    get "/lorem/image/400/200/sports"
    assert_equal 200, last_response.status
    assert_equal "image/jpeg", last_response.headers["Content-Type"]
  end

  def test_bad_url
    response = OpenStruct.new(:code => 404, :body => "not found")

    Net::HTTP.stub(:get_response, response) do   # stub goes away once the block is done
      get "/lorem/image/100/200"
      assert_equal 404, last_response.status
    end
  end
end
