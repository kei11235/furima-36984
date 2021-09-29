class Item < ApplicationRecord

  validates :name, presence: true
  validates :explain, presence:true
  with_options numericality: { other_than: 1 , message: "選択項目が足りません" } do
    validates :category_id
    validates :status_id
    validates :shopping_charge_id
    validates :area_id
    validates :days_id
  end
  validates :price, numericality: { in: 300..9999999, message: 'は￥300~￥9,999,999の範囲で値段をつけてください' }, format: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください" }
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item
  belongs_to :status
  belongs_to :shopping_charge
  belongs_to :area
  belongs_to :days

end
