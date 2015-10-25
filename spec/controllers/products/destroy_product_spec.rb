require 'rails_helper'

describe Api::ProductsController do

  before do
    @gem = FactoryGirl.build(:gem)
    @gem.save
  end

  it "deleting gem is successful when user is admin" do
    allow(@controller).to receive(:create_product?).and_return(true)
    delete :destroy, :id => @gem.id
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"notice"=>"Gem successfully destroyed."')
  end

  it "deleting gem is unsuccessful when user is not admin" do
    delete :destroy, :id => @gem.id
    expect(response).to_not be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"error"=>"Could not update gem, check validations"')
  end
end
