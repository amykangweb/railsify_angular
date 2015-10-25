require 'rails_helper'

describe Api::ProductsController do

  before do
    @gem = FactoryGirl.build(:gem)
    @gem.save
  end

  it "updating gem is successful when user is admin" do
    allow(@controller).to receive(:create_product?).and_return(true)
    put :update, :id => @gem.id, :product => { :name => "Onyx", :price => 2 }
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"name"=>"Onyx"')
    expect(data).to have_content('"price"=>2')
  end

  it "creating gem is unsuccessful when user is not admin" do
    put :update, :id => @gem.id, :product => { :name => "Onyx", :price => 2 }
    expect(response).to_not be_successful
  end
end
