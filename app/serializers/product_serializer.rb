class ProductSerializer < ActiveModel::Serializer
  attributes :title, :price, :zipcode, :seller, :thumbnailHd, :created_at

  def seller
    object.client.name
  end
end
