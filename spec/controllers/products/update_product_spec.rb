require 'rails_helper'

describe Api::ProductsController do
  fixtures :products

  before do
    @gem = FactoryGirl.build(:gem)
    @gem.save
    allow(@controller).to receive(:create_product?).and_return(true)
  end

  it "updating gem is successful when user is admin" do
    put :update, :id => @gem.id, :product => { :name => "Onyx", :price => 2 }
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"name"=>"Onyx"')
    expect(data).to have_content('"price"=>2')
  end
end
