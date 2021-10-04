class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipalities, :address, :building, :phone_num, :token, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は「-（ハイフン）」を用いた半角数字で正しく登録してください", allow_blank: true}
    validates :municipalities
    validates :address
    validates :phone_num, format: { with: /0{1}\d{9,10}/, message: 'は0から始まる半角数字のみ入力してください', allow_blank: true }
    validates :token
    validates :user_id
    validates :item_id
  end
  validates :area_id, numericality: { other_than: 1, message: 'は選択項目が足りません' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, municipalities: municipalities, address: address, building: building, phone_num: phone_num, order_id: order.id)
  end
end