require 'test_helper'

class ProductsTestTest < ActionDispatch::IntegrationTest
  test "returns list of products as json" do
    get "/api/products"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
