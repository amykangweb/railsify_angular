require 'rails_helper'

describe Api::ProductsController do

  before do
    allow(@controller).to receive(:create_product?).and_return(true)
  end

  it "creating gem is successful when user is admin" do
    post :create, :product => { :name => "Diamond", :price => 2 }
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"name"=>"Diamond"')
    expect(data).to have_content('"price"=>2')
  end
end
