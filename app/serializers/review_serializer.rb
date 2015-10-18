class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :author, :stars, :body
end
