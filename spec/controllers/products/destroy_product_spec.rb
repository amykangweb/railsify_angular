require 'rails_helper'

describe Api::ProductsController do

  before do
    @gem = FactoryGirl.build(:gem)
    @gem.save
    allow(@controller).to receive(:create_product?).and_return(true)
  end

  it "deleting gem is successful when user is admin" do
    delete :destroy, :id => @gem.id
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"notice"=>"Gem successfully destroyed."')
  end
end
