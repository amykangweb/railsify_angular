class ProductSerializer < ActiveModel::Serializer
  attributes :id,
  :name,
  :price,
  :description,
  :specifications,
  :image

  has_many :reviews
end
