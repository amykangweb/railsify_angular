require 'rails_helper'

describe Api::ReviewsController do

  before do
    @product = FactoryGirl.build(:gem)
    @product.save
  end

  it "creating review is successful for anyone" do
    post :create, :review => { :stars => 2, :body => "good",
                              :author => "amy@mail.com",
                              :product_id => @product.id }
    expect(response).to be_successful
    data = JSON.parse(response.body)
    expect(data).to have_content('"author"=>"amy@mail.com"')
    expect(data).to have_content('"body"=>"good"')
    expect(data).to have_content('"stars"=>2')
  end
end
