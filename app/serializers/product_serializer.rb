class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :adjusted_price, :quantity, :category

  def category
    object.category.name
  end
end
