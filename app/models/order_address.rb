class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipalities, :address, :building, :phone_num, :order, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は「-（ハイフン）」を用いた半角数字で登録してください", allow_blank: true}
    validates :municipalities
    validates :address
    validates :phone_num, numericality: { with: /0\d{9,10}/, message: 'は半角数字のみ入力してください', allow_blank: true }
    validates :user_id
    validates :item_id
  end
  validates :area, numericality: { other_than: 1, message: 'は選択項目が足りません' }
  
end