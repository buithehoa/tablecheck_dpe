class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :category

  def category
    object.category.name
  end
end
