class ProductSerializer < ActiveModel::Serializer
  attributes :name,
  :price,
  :description,
  :specifications,
  :image
end
