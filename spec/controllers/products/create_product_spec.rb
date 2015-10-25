require 'rails_helper'

describe Api::ProductsController do

  it "creating gem is successful when user is admin" do
    allow(@controller).to receive(:create_product?).and_return(true)
    post :create, :product => { :name => "Diamond", :price => 2 }
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"name"=>"Diamond"')
    expect(data).to have_content('"price"=>2')
  end

  it "creating gem is unsuccessful when user is not admin" do
    post :create, :product => { :name => "Diamond", :price => 2 }
    expect(response).to_not be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"error"=>"Could not create gem, check validations"')
  end
end
