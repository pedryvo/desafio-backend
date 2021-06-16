class CartSerializer < ActiveModel::Serializer
  attributes :client_id, :purchase_id, :value, :date, :card_number

  def client_id
    object.client.id
  end

  def purchase_id
    object.id
  end

  def value
    object.total_price
  end

  def date
    object.updated_at.strftime("%d/%m/%Y")
  end

  def card_number
    object.client.card.cardNumber.to_s.gsub(/.(?=.{4})/, "*").gsub(/(.{4})/, '\1 ').delete_suffix(' ')
  end
end
