require 'test_helper'

class ProductsTestTest < ActionDispatch::IntegrationTest
  test "returns list of products as json" do
    get "/api/products"
    assert_equal 200, response.status
    data = JSON.parse(response.body, symbolize_names: true)
    data[:products].detect { |stone| stone[:name] == "Ruby" }[:description].match("/red/")
    assert_equal Mime::JSON, response.content_type
  end
end
